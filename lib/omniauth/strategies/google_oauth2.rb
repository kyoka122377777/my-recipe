require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class GoogleOauth2 < OmniAuth::Strategies::OAuth2
      def callback_phase
        Rails.logger.debug("Access token: #{access_token.inspect}")
        Rails.logger.debug("Access token methods: #{access_token.methods.inspect}")
          
        super
      rescue ::OAuth2::Error, CallbackError => e
        Rails.logger.error("OAuth2 Error: #{e.message}")
        fail!(:oauth_error, e)
      end
    end
  end
end

