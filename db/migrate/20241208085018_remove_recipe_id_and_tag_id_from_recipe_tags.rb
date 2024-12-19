class RemoveRecipeIdAndTagIdFromRecipeTags < ActiveRecord::Migration[7.2]
  def change
    # Remove indices associated with recipe_id and tag_id
    remove_index :recipe_tags, [:recipe_id, :tag_id], if_exists: true
    remove_index :recipe_tags, :recipe_id, if_exists: true
    remove_index :recipe_tags, :tag_id, if_exists: true

    # Remove the columns
    remove_column :recipe_tags, :recipe_id, :bigint, if_exists: true
    remove_column :recipe_tags, :tag_id, :bigint, if_exists: true
  end
end
