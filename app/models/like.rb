# == Schema Information
#
# Table name: likes
#
#  id           :bigint           not null, primary key
#  likable_type :string
#  upvote       :boolean          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  likable_id   :bigint
#
# Indexes
#
#  index_likes_on_likable  (likable_type,likable_id)
#
class Like < ApplicationRecord
  belongs_to :likable, polymorphic: true

  validates :post, presence: true
  validates :post, uniqueness: { scope: :user }
end
