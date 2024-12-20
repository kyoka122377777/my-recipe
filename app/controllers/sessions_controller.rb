class SessionsController < ApplicationController
  # ログインフォームの表示
  def new
  end

  def create ##通常ログイン
    if params[:email].present? && params[:password].present?
      @user = User.authenticate(params[:email], params[:password])
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
    else
      flash[:error] = 'メールアドレスとパスワードを入力してください'
      render :new
    end
  end

  def google_oauth2 #googleログイン処理
    auth = request.env['omniauth.auth']

    if auth
      # ユーザーを検索または作成
      @user = User.find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
        user.email = auth.info.email
        user.name = auth.info.name
        user.password = SecureRandom.hex(10) if user.password_digest.blank? # パスワードがない場合はランダム生成
      end

      # ログイン処理
      auto_login(@user)
      session[:user_id] = @user.uuid

      flash[:notice] = 'Googleアカウントでログインしました'
      redirect_to home_path
    else
      flash[:error] = 'Googleログインに失敗しました'
      redirect_to login_path
    end
  end
  # def create
  #   # メールとパスワードによる認証
  #   if params[:email] && params[:password]  # 通常のログイン（メールとパスワード）
  #     @user = User.authenticate(params[:email], params[:password], params[:remember_me])
  #     if @user
  #       auto_login(@user, params[:remember_me] == '1')
  #       session[:user_id] = @user.uuid
  #       Rails.logger.debug "Session User ID: #{session[:user_id]}"
  #       flash[:notice] = 'ログインしました'
  #       redirect_to home_path
  #     else
  #       flash[:error] = 'メールアドレスまたは、パスワードが間違っています'
  #       render :new
  #     end
  #   else  # Googleログイン
  #     auth = request.env["omniauth.auth"]
  #     @user = User.find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
  #       user.email = auth.info.email
  #       user.name = auth.info.name
  #     end

  #     session[:user_id] = @user.uuid
  #     flash[:notice] = 'Googleアカウントでログインしました'
  #     redirect_to home_path
  #   end
  # end

  # ログアウト処理
  def destroy
    session[:user_id] = nil
    flash[:notice] = 'ログアウトしました'
    redirect_to welcome_index_path
  end
end
