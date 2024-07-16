# == Schema Information
#
# Table name: posts
#
#  id           :bigint           not null, primary key
#  caption      :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  community_id :bigint           not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_posts_on_community_id  (community_id)
#  index_posts_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (community_id => communities.id)
#  fk_rails_...  (user_id => users.id)
#
class Post < ApplicationRecord
  require 'securerandom'

  belongs_to :user
  belongs_to :community
  has_many :likes, dependent: :delete_all
  has_many :comments, dependent: :delete_all

  validates :caption, presence: true

  scope :ordered, -> { order(created_at: :desc) }

  def likes_amount
    self.likes.length
  end
end
