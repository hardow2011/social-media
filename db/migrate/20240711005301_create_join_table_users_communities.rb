class CreateJoinTableUsersCommunities < ActiveRecord::Migration[7.1]
  def change
    create_join_table :users, :communities do |t|
      t.index [:user_id, :community_id], unique: true
    end
  end
end
