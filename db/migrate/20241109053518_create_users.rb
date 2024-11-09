class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :name, null: false           # ユーザー名
      t.string :email, null: false          # メールアドレス
      t.string :crypted_password            # Sorcery用の暗号化パスワード
      t.string :salt                        # Sorcery用のソルト

      t.timestamps
    end

    # emailに一意制約を追加
    add_index :users, :email, unique: true
  end
end
