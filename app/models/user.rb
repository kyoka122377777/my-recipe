class User < ApplicationRecord
  # パスワードのハッシュ化
  has_secure_password
  
  # バリデーション
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }, if: :password

  # パスワード確認が一致するかどうかを検証（`password_confirmation`はフォームから送られる）
  validates :password_confirmation, presence: true, if: :password

  # ユーザー名とメールアドレスの一意性の検証
  before_save :downcase_email

  private

  # メールアドレスを小文字に変換
  def downcase_email
    self.email = email.downcase
  end
end

