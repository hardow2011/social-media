# == Schema Information
#
# Table name: votes
#
#  id           :bigint           not null, primary key
#  upvote       :boolean          not null
#  votable_type :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           not null
#  votable_id   :bigint
#
# Indexes
#
#  idx_on_upvote_user_id_votable_id_votable_type_d7ddbfacd2  (upvote,user_id,votable_id,votable_type) UNIQUE
#  index_votes_on_user_id                                    (user_id)
#  index_votes_on_votable                                    (votable_type,votable_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Vote < ApplicationRecord
  belongs_to :votable, polymorphic: true
  belongs_to :user

  validates :upvote, inclusion: [true, false]
  validates :user, uniqueness: { scope: [:votable, :upvote], message: "can't be repeated" }
end
