class AddHighlightedContentToModification < ActiveRecord::Migration[5.1]
  def change
    add_column :modifications, :highlighted_content, :text
  end
end
