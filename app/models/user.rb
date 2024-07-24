# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  username               :string(20)       not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_username              (username) UNIQUE
#
class User < ApplicationRecord
  include DataFormatting
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :delete_all
  has_many :comments, dependent: :delete_all

  has_and_belongs_to_many :communities

  def to_param
    username
  end

  def self.get_by_username(username)
    User.find_sole_by(username: username)
  end

  validates :username, presence: true, uniqueness: true,
    format: { with: DataFormatting::HANDLE_FORMAT, message: 'must only contain letter, numbers and hyphens' }

  def belongs_to_community?(community)
    self.communities.include?(community)
  end

  # TODO: eventually paginate
  def feed_posts
    # self.communities.extract_associated(:posts).flatten.sort_by(&:id).reverse
    Post.joins(:community).joins(community: :users).where(communities_users: {user_id: self.id}).ordered
  end
end
