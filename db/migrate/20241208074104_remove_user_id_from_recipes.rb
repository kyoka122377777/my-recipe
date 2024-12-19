class RemoveUserIdFromRecipes < ActiveRecord::Migration[7.2]
  def change
    remove_column :recipes, :user_id, :bigint
  end
end
