class CreateLike < ActiveRecord::Migration[7.1]
  def change
    create_table :likes do |t|
      t.references :likable, polymorphic: true
      t.boolean :upvote, null: false

      t.timestamps
    end
  end
end
