class RemoveNameFromCommunities < ActiveRecord::Migration[7.1]
  def change
    remove_column :communities, :name, :string
  end
end
