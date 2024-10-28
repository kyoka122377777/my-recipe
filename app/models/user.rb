class User < ApplicationRecord
  # バリデーションの設定
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :reset_password_token, uniqueness: true, allow_nil: true

  # パスワードのハッシュ化と認証メソッドを追加
  has_secure_password
  has_many :recipes, dependent: :destroy
end
