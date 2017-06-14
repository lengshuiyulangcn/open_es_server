class AddWunderlistListIdToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :wunderlist_listId, :string
  end
end
