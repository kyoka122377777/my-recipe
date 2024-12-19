class AddUuidToTagsAndRecipes < ActiveRecord::Migration[7.2]
  def change
    # tagsテーブルにUUIDを追加
    add_column :tags, :uuid, :uuid, default: -> { "gen_random_uuid()" }, null: false
    add_index :tags, :uuid, unique: true

    # recipesテーブルにUUIDを追加
    add_column :recipes, :uuid, :uuid, default: -> { "gen_random_uuid()" }, null: false
    add_index :recipes, :uuid, unique: true
  end
end
