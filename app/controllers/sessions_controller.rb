class SessionsController < ApplicationController
  # ログインフォームの表示
  def new
  end

  # ログイン処理（メールとパスワード）
  def create
    # メールとパスワードによる認証
    @user = User.authenticate(params[:email], params[:password])
    if @user
      session[:user_id] = @user.id
      flash[:notice] = 'ログインしました'
      redirect_to home_path
    else
      flash[:error] = 'メールアドレスまたは、パスワードが間違っています'
      render :new
    end
  end

  # 外部認証（Google OAuth）でのログイン処理
  def auth_at_provider
    # 外部プロバイダ（Google）で認証を開始
    redirect_to "/auth/google"
  end

  # Google認証のコールバック処理
  def auth_at_provider_callback
    # Googleからのコールバック処理
    user = User.find_or_create_from_auth_hash(request.env['omniauth.auth'])
    if user
      # 認証成功時の処理
      session[:user_id] = user.id
      redirect_to root_path, notice: 'ログイン成功！'
    else
      redirect_to login_path, alert: 'ログイン失敗'
    end
  end

  # ログアウト処理
  def destroy
    session[:user_id] = nil
    flash[:notice] = 'ログアウトしました'
    redirect_to welcome_index_path
  end

  def google_auth
    # OmniAuthによるGoogle認証の情報を取得
    auth = request.env['omniauth.auth']
    
    # ユーザー情報を取得または新規作成
    user = User.find_or_create_by(email: auth.info.email) do |u|
      u.username = auth.info.name
      u.password = SecureRandom.hex(10)  # 仮パスワード
    end

    # ログイン処理
    session[:user_id] = user.id

    # ログイン後のリダイレクト
    redirect_to home_path, notice: "Googleでログインしました"
  end

  def auth_failure
    # 認証失敗時の処理
    redirect_to root_path, alert: "認証に失敗しました"
  end

  private

  # Omniauth認証情報（Googleの情報）を取得
  def auth_hash
    request.env['omniauth.auth']
  end
end
