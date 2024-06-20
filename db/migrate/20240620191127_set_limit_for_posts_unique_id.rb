class SetLimitForPostsUniqueId < ActiveRecord::Migration[7.1]
  def up
    change_column :posts, :unique_id, :string, limit: 11
  end

  def down
    change_column :posts, :unique_id, :string, limit: null
  end
end
