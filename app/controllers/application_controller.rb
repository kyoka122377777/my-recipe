class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  #protect_from_forgery unless: -> { request.format.json? || request.path.start_with?("/oauth/") }

  def require_login
    unless current_user
      redirect_to login_path, alert: 'You must be logged in to access this page.'
    end
  end

  def current_user
    Rails.logger.debug "Session User ID: #{session[:user_id]}"  
    @current_user ||= User.find_by(uuid: session[:user_id])
  end
  helper_method :current_user
end
