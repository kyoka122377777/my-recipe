class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @recipes = Recipe.where(user_id: current_user.id) if current_user
    @recipes ||= []  # もし@recipesがnilの場合に空の配列を設定
  end

  private

  def authenticate_user!
    unless session[:user_id]
      redirect_to login_path
    end
  end
end