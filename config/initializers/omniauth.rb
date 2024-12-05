Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'], {
  scope: 'email,profile',
  redirect_uri: ENV['GOOGLE_CALLBACK_URL'],  # 環境変数で設定されたURLが正しいか確認
  prompt: 'select_account',
  }
end
