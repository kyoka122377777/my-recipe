class ChangeRecipeIdToUserUuidInQuantities < ActiveRecord::Migration[7.2]
  def change
    # quantitiesテーブルのrecipe_idをuser_uuidに変更
    remove_column :quantities, :recipe_id, :bigint
    add_column :quantities, :user_uuid, :uuid, null: false, default: -> { "gen_random_uuid()" }
  end
end
