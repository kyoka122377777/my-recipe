class SessionsController < ApplicationController
  # ログインフォームの表示
  def new
  end

  # ログイン処理（メールとパスワード）
  # def create
  #   # メールとパスワードによる認証
  #   @user = User.authenticate(params[:email], params[:password])
  #   if @user
  #     session[:user_id] = @user.uuid
  #     Rails.logger.debug "Session User ID: #{session[:user_id]}"
  #     flash[:notice] = 'ログインしました'
  #     redirect_to home_path
  #   else
  #     flash[:error] = 'メールアドレスまたは、パスワードが間違っています'
  #     render :new
  #   end
  # end
  def create
    # メールとパスワードによる認証
    if params[:email] && params[:password]  # 通常のログイン（メールとパスワード）
      @user = User.authenticate(params[:email], params[:password], params[:remember_me])
      if @user
        auto_login(@user, params[:remember_me] == '1')
        session[:user_id] = @user.uuid
        Rails.logger.debug "Session User ID: #{session[:user_id]}"
        flash[:notice] = 'ログインしました'
        redirect_to home_path
      else
        flash[:error] = 'メールアドレスまたは、パスワードが間違っています'
        render :new
      end
    else  # Googleログイン
      auth = request.env["omniauth.auth"]
      @user = User.find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
        user.email = auth.info.email
        user.name = auth.info.name
      end

      session[:user_id] = @user.uuid
      flash[:notice] = 'Googleアカウントでログインしました'
      redirect_to home_path
    end
  end

  # ログアウト処理
  def destroy
    session[:user_id] = nil
    flash[:notice] = 'ログアウトしました'
    redirect_to welcome_index_path
  end
end
