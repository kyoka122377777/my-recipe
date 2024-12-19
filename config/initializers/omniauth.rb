Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'], scope: 'email,profile'

  OmniAuth.config.logger = Rails.logger

  OmniAuth.config.on_failure = Proc.new do |env|
    UsersController.action(:omniauth_failure).call(env)
    #this will invoke the omniauth_failure action in UsersController.
  end

end

