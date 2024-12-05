class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  include Sorcery::Controller

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  helper_method :current_user
end
