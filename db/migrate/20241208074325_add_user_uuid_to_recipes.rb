class AddUserUuidToRecipes < ActiveRecord::Migration[7.2]
  def change
    add_column :recipes, :user_uuid, :uuid, null: false
    add_index :recipes, :user_uuid
  end
end
