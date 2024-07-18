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
#  user_id      :bigint           not null
#
# Indexes
#
#  index_likes_on_likable  (likable_type,likable_id)
#  index_likes_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Like < ApplicationRecord
  belongs_to :likable, polymorphic: true
  belongs_to :user
end
