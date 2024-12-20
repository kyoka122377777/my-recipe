class User < ApplicationRecord
  authenticates_with_sorcery!

  self.primary_key = 'uuid'
  has_many :recipes, dependent: :destroy, foreign_key: 'user_uuid'
  has_many :sns_credentials, dependent: :destroy
  accepts_nested_attributes_for :sns_credentials

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, confirmation: true, length: { minimum: 6 }, if: :password_required?
  validates :remember_me_token, uniqueness: true, allow_nil: true

  # OAuthトークンのリフレッシュ
  def refresh_access_token!
    return unless refresh_token && (token_expires_at.nil? || token_expires_at < Time.current)

    client = OAuth2::Client.new(
      ENV['GOOGLE_CLIENT_ID'],
      ENV['GOOGLE_CLIENT_SECRET'],
      site: 'https://oauth2.googleapis.com',
      token_url: '/token'
    )
    token = OAuth2::AccessToken.new(client, access_token, refresh_token: refresh_token)

    refreshed_token = token.refresh!

    update!(
      access_token: refreshed_token.token,
      refresh_token: refreshed_token.refresh_token || refresh_token,
      token_expires_at: Time.at(refreshed_token.expires_at)
    )
  rescue OAuth2::Error => e
    Rails.logger.error "Failed to refresh token: #{e.message}"
    nil
  end

  # OAuthユーザーの検索または作成
  def self.find_or_create_for_oauth(auth)
    user = find_or_initialize_by(provider: auth.provider, uid: auth.uid)
    if user.new_record?
      user.email = auth.info.email
      user.name = auth.info.name
      user.password = SecureRandom.hex(16) # 仮パスワード
      user.save!
    end
    user
  end

  private

  def password_required?
    provider.blank? && uid.blank?
  end
end
