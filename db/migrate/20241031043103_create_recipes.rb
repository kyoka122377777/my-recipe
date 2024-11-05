class CreateRecipes < ActiveRecord::Migration[7.2]
  def change
    create_table :recipes do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.references :user, null: false, foreign_key: true
      t.string :image  # 任意の画像フィールド

      t.timestamps
    end
  end
end
