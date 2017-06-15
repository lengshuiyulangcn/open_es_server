class AddAssigneeToSection < ActiveRecord::Migration[5.1]
  def change
    add_column :sections, :assignee_id, :integer, index: true, foreign_key: true
  end
end
