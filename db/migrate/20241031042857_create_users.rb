class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :name, null: false            # ユーザー名
      t.string :email, null: false           # メールアドレス
      t.string :password_digest, null: false  # ハッシュ化されたパスワード
      t.string :reset_password_token         # パスワードリセット用トークン
      t.datetime :reset_password_sent_at     # パスワードリセット用トークン送信時間
      t.datetime :remember_created_at         # ログイン情報を記憶するためのカラム

      t.timestamps
    end
    
    # emailに一意制約を追加
    add_index :users, :email, unique: true
    # reset_password_tokenに一意制約を追加
    add_index :users, :reset_password_token, unique: true
  end
end
