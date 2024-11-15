class SessionsController < ApplicationController
  def new
    @user = User.new  # Initialize a new User instance for the login form
  end

  # def create
  #   user = User.find_by(email: params[:session][:email])
  #   if user&.authenticate(params[:session][:password])
  #     session[:user_id] = user.id
  #     redirect_to root_path, notice: 'Logged in successfully.'
  #   else
  #     flash.now[:alert] = 'Invalid email or password.'
  #     render :new
  #   end
  # end
  def create
    user = User.authenticate(params[:session][:email], params[:session][:password])
    Rails.logger.debug "ユーザー: #{user.inspect}" 

    if user
      Rails.logger.debug "認証成功: ユーザーID #{user.id}"
      session[
        :user_id] = user.id
        redirect_to home_path, 
      notice: 'ログインに成功しました'
    else
      Rails.logger.debug "認証失敗" # 認証失敗のログ出力
      flash.now[:alert] = 'メールアドレスまたはパスワードが間違っています'
      render :new
    end
  end
  

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Logged out successfully.'
  end
end
