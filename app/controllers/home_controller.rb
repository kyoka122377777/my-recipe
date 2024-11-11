class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    #@recipes = Recipe.where(user_id: current_user.id) if current_user
  end

  private

  def authenticate_user!
    # Redirect to login if the user is not authenticated
    redirect_to login_path unless session[:user_id]
  end
end
