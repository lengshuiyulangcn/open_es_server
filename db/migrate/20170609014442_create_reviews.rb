class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.references :user, foreign_key: true
      t.text :content
      t.integer :rating
      t.references :section, foreign_key: true

      t.timestamps
    end
  end
end
