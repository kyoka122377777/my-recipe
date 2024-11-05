class WelcomeController < ApplicationController

  def index
    # トップページ用のアクション
  end

  private

  def authenticate_user!
    unless user_signed_in?
      redirect_to login_path # ログインページへリダイレクト
    end
  end
end
