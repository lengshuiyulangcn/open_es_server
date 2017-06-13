class RemoveCommentAndRawContentFromModification < ActiveRecord::Migration[5.1]
  def change
    remove_column :modifications, :highlighted_content, :text
    remove_column :modifications, :comment, :text
  end
end
