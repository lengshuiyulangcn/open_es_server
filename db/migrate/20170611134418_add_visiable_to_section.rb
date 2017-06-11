class AddVisiableToSection < ActiveRecord::Migration[5.1]
  def change
    add_column :sections, :visiable, :boolean, default: false
  end
end
