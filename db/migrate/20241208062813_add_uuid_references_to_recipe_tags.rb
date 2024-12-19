class AddUuidReferencesToRecipeTags < ActiveRecord::Migration[7.2]
  def change
    # recipe_tagsテーブルにrecipe_uuidとtag_uuidを追加
    add_column :recipe_tags, :recipe_uuid, :uuid, null: false
    add_column :recipe_tags, :tag_uuid, :uuid, null: false

    # 外部キーを設定して、recipesとtagsのuuidを参照する
    add_foreign_key :recipe_tags, :recipes, column: :recipe_uuid, primary_key: :uuid
    add_foreign_key :recipe_tags, :tags, column: :tag_uuid, primary_key: :uuid

    # インデックスを追加
    add_index :recipe_tags, :recipe_uuid
    add_index :recipe_tags, :tag_uuid

    # 複合インデックスを追加（必要に応じて）
    add_index :recipe_tags, [:recipe_uuid, :tag_uuid], unique: true
  end
end
