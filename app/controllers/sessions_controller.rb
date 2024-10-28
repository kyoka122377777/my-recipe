class SessionsController < ApplicationController
  def new
    @resource = User.new # Userモデルの新しいインスタンスを作成
    @resource_name = 'user'
  end

  def create
    user = User.find_by(email: params[:session][:email])
    Rails.logger.debug "ユーザー: #{user.inspect}" 

    if user && user.authenticate(params[:session][:password])
      Rails.logger.debug "認証成功: ユーザーID #{user.id}"
      session[:user_id] = user.id

      redirect_to home_path, notice: t('sessions.create.success')
    else
      Rails.logger.debug "認証失敗" # 認証失敗のログ出力
      flash.now[:alert] = t('sessions.create.invalid_credentials')
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: t('sessions.destroy.success') # i18n対応
  end
end
