require 'pry'
OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'], {
    scope: 'email,profile',
    provider_ignores_state: true
  }
end

OmniAuth.config.full_host = Rails.env.production? ? 'https://myrecipe.info' : 'http://localhost:3000'
OmniAuth.config.allowed_request_methods = [:post, :get]

OmniAuth.config.on_failure = Proc.new do |env|
  message = env['omniauth.error']&.message || 'Authentication failed.'
  Rails.logger.error("OmniAuth Error: #{message}")
  [302, {'Location' => "/auth/failure?message=#{message}"}, []]
end
