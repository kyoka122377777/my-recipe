class RemoveOldForeignKeyFromRecipeTags < ActiveRecord::Migration[7.2]
  def change
    # Ensure foreign key exists before attempting to remove it
    if foreign_key_exists?(:recipe_tags, :recipes)
      remove_foreign_key :recipe_tags, :recipes
    end

    # Use reversible block to define actions for both up and down directions
    reversible do |dir|
      dir.up do
        # You can add a new foreign key here if needed, or leave it as is.
        # For example, if you want to remove the foreign key and not add a new one:
        # No further action needed as we're just removing the foreign key.
      end

      dir.down do
        # Re-add the foreign key if rolling back the migration
        add_foreign_key :recipe_tags, :recipes, column: :recipe_id
      end
    end
  end
end
