class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string :unique_id, index: { unique: true }, null: false
      t.string :caption, null: false
      # t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
