class AddAssigneeToSection < ActiveRecord::Migration[5.1]
  def change
    add_reference :sections, :assignee, index: true, foreign_key: true
  end
end
