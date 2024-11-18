class SorceryCore < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :email,            null: false, index: { unique: true }
      t.string :crypted_password, null: false
      t.string :salt,             null: false
      t.string :username,         null: false
      t.timestamps                null: false
    end
  end
end
