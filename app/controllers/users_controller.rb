class UsersController < ApplicationController
  #before_action :authenticate_user! # ユーザーがログインしているか確認
  before_action :set_user, only: [:show, :edit, :update]

  def new
    @user = User.new # ユーザーの新しいインスタンスを作成
  end

  def create
    # @user = User.new(user_params)
    # if @user.save
    #   redirect_to home_path, notice: t('users.create.success') # i18n対応
    # else
    #   flash.now[:alert] = @user.errors.full_messages.join(", ") # エラーメッセージをフラッシュメッセージに設定
    #   render :new
    # end
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id  # ユーザーをサインイン状態にする
      redirect_to home_path, notice: t('users.create.success') # i18n対応
    else
      flash.now[:alert] = @user.errors.full_messages.join(", ") # エラーメッセージをフラッシュメッセージに設定
    render :new
    end
  end

  # アカウント管理画面の表示
  def show
    @user = current_user # 現在のユーザー情報を取得
  end

  # アカウント編集画面の表示
  def edit
    @user = current_user # 現在のユーザー情報を取得
  end

  def update
    @user = current_user # 現在のユーザー情報を取得
    if @user.update(user_params)
      redirect_to account_path, notice: t('users.update.success') # i18n対応
    else
      render :edit, alert: t('users.update.failure') # i18n対応
    end
  end

  private

  def set_user
    @user = current_user 
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :icon)
  end
end