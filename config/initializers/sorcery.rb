Rails.application.config.sorcery.configure do |config|
  # OAuthプロバイダーの設定
  config.configure do |c|
    c.external_providers = [:google]

    # Google OAuth の設定
    c.google.key = ENV['GOOGLE_CLIENT_ID']
    c.google.secret = ENV['GOOGLE_CLIENT_SECRET']
    c.google.callback_url = ENV['GOOGLE_CALLBACK_URL']

    # ユーザー設定
    c.user_config do |user|
      user.stretches = 1 if Rails.env.test?
      user.authentications_class = Authentication
    end

    # 外部認証クラス設定
    c.authentications_class = Authentication
  end
end
