class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id  # Sorceryを使ったログイン
      redirect_to home_path, notice: "ユーザー登録が完了しました"
    else
      flash.now[:alert] = @user.errors.full_messages.join(", ")
      render :new
    end
  end

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    if current_user.update(user_params)
      redirect_to account_path, notice: "プロフィールが更新されました"
    else
      flash.now[:alert] = "更新に失敗しました"
      render :edit
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
