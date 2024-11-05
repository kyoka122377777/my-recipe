class CreateQuantities < ActiveRecord::Migration[7.2]
  def change
    create_table :quantities do |t|
      t.references :recipe, null: false, foreign_key: true
      t.string :ingredient_name, null: false
      t.string :amount_with_unit, null: false

      t.timestamps
    end
  end
end
