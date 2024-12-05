class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :recipes, dependent: :destroy

  has_many :authentications, dependent: :destroy

  validates :username, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, confirmation: true, length: { minimum: 6 }, if: -> { new_record? || changes[:password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:password] }

  def self.create_from_auth_hash(auth_hash)
    user = User.create(
      name: auth_hash['info']['name'],
      email: auth_hash['info']['email'],
      password: SecureRandom.hex(10)  # 外部認証ではパスワードをランダムで生成
    )
    user.authentications.create(
      provider: auth_hash['provider'],
      uid: auth_hash['uid']
    )
    user
  end

  # Googleログイン用のメソッド
  def self.from_google(auth)
    user = User.find_or_initialize_by(provider: auth.provider, uid: auth.uid)
    user.email = auth.info.email
    user.username = auth.info.name
    user.password = SecureRandom.hex(16) # パスワードが必要な場合は仮で設定
    user.save
    user
  end
end
