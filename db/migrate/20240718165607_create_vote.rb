class CreateVote < ActiveRecord::Migration[7.1]
  def change
    create_table :votes do |t|
      t.references :votable, polymorphic: true
      t.boolean :upvote, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
