class AddWunderlistIdToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :wunderlistId, :string
  end
end
