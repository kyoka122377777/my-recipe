class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_login, except: [:new, :create]


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
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to account_path, notice: "プロフィールが更新されました"
    else
      flash.now[:alert] = "更新に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "ログアウトしました"
  end

  # Google OAuthのコールバック用
  def oauth
    user = User.from_google(request.env["omniauth.auth"])
    
    if user.persisted?
      # ログインしてユーザーをセッションに設定
      session[:user_id] = user.id
      redirect_to home_path, notice: "ログインしました！"
    else
      # ユーザーを新規作成
      redirect_to new_user_path, alert: "Googleアカウントでのログインに失敗しました。"
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
