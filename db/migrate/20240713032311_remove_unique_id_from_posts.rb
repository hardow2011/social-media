class RemoveUniqueIdFromPosts < ActiveRecord::Migration[7.1]
  def change
    remove_column :posts, :unique_id, :string
  end
end
