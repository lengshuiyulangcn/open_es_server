class CreateModifications < ActiveRecord::Migration[5.1]
  def change
    create_table :modifications do |t|
      t.references :section, foreign_key: true
      t.references :user, foreign_key: true
      t.text :content
      t.text :comment

      t.timestamps
    end
  end
end
