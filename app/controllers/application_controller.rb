class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :set_user_signed_in
  helper_method :current_user, :user_signed_in?  # user_signed_in?をヘルパーメソッドとして追加

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def user_signed_in?
    current_user.present?
  end


  protected

  # ログイン後の遷移先を指定するメソッド
  def after_sign_in_path_for(resource)
    home_path # 遷移したいパスに変更
  end

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def set_user_signed_in
    @user_signed_in = user_signed_in? # 現在のユーザーのログイン状態を確認
  end
end
