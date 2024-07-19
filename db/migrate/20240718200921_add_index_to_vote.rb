class AddIndexToVote < ActiveRecord::Migration[7.1]
  def change
    add_index :votes, [:upvote, :user_id, :votable_id, :votable_type], unique: true
  end
end
