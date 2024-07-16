class AddCreatedByToCommunity < ActiveRecord::Migration[7.1]
  def change
    add_reference :communities, :creator, null: false, foreign_key: { to_table: :users }
  end
end
