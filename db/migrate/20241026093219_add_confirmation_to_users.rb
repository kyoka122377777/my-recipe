class AddConfirmationToUsers < ActiveRecord::Migration[7.0]
  def change
    # confirmed_atカラムをdatetime型で追加
    add_column :users, :confirmed_at, :datetime

    # confirmation_tokenカラムをstring型で追加
    add_column :users, :confirmation_token, :string

    # confirmation_tokenにユニークインデックスを追加（オプション）
    add_index :users, :confirmation_token, unique: true
  end
end
