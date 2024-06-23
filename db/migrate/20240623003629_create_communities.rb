class CreateCommunities < ActiveRecord::Migration[7.1]
  def change
    create_table :communities do |t|
      t.string :name, null: false
      t.string :handle, null: false, index: { unique: false }
      t.string :description, null: false

      t.timestamps
    end
  end
end
