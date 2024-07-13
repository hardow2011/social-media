# == Schema Information
#
# Table name: posts
#
#  id           :bigint           not null, primary key
#  caption      :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  community_id :bigint           not null
#  unique_id    :string(11)       not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_posts_on_community_id  (community_id)
#  index_posts_on_unique_id     (unique_id) UNIQUE
#  index_posts_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (community_id => communities.id)
#  fk_rails_...  (user_id => users.id)
#
#
# TODO: remove unique_id
class Post < ApplicationRecord
  require 'securerandom'

  belongs_to :user
  belongs_to :community
  has_many :likes, dependent: :delete_all
  has_many :comments, dependent: :delete_all

  before_validation :assign_unique_id, on: :create

  validates :unique_id, format: { with: /[a-zA-Z0-9]*/ }, length: { is: 11 },
            presence: true, uniqueness: true, allow_blank: false,
            allow_nil: false, on: :create

  validates :caption, presence: true

  scope :ordered, -> { order(id: :desc) }

  attr_readonly :unique_id

  def likes_amount
    self.likes.length
  end

  private

  def assign_unique_id
    self.unique_id = SecureRandom.alphanumeric(11)
    assign_unique_id if Post.exists?(unique_id: self.unique_id)
  end
end
