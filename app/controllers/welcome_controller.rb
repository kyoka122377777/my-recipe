class WelcomeController < ApplicationController
  #before_action :authenticate_user!, only: [:index] # インデックスアクションでのみ認証を適用

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
