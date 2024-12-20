class OauthController < ApplicationController
  skip_forgery_protection only: [:callback]  # CSRF トークン検証をスキップ
  skip_before_action :require_login, raise: false
  include Sorcery::Controller

  def oauth
    login_at(params[:provider])
  end

  def callback
    provider = auth_params[:provider]

    # 認証情報を取得
    auth_hash = sorcery_fetch_access_token(provider)

    # 既存のユーザーをプロバイダ情報を元に検索し、存在すればログイン
    if (@user = login_from(provider))
      update_oauth_tokens(@user, auth_hash)  # トークンを更新
      redirect_to root_path, notice: "#{provider.titleize}アカウントでログインしました"
    else
      begin
        # ユーザーが存在しない場合はプロバイダ情報を元に新規ユーザーを作成し、ログイン
        @user = signup_and_login(provider, auth_hash)
        redirect_to root_path, notice: "#{provider.titleize}アカウントでログインしました"
      rescue
        redirect_to root_path, alert: "#{provider.titleize}アカウントでのログインに失敗しました"
      end
    end
  end

  private

  def auth_params
    params.permit(:code, :provider)
  end

  def signup_and_login(provider, auth_hash)
    @user = create_from(provider)
    update_oauth_tokens(@user, auth_hash)  # トークンを保存
    reset_session
    auto_login(@user)
  end

  def sorcery_fetch_access_token(provider)
    # Sorceryが提供するメソッドでOAuth情報を取得
    auth_hash = sorcery_fetch_user_hash(provider)
    {
      access_token: auth_hash[:credentials][:token],
      refresh_token: auth_hash[:credentials][:refresh_token],
      expires_at: Time.at(auth_hash[:credentials][:expires_at])
    }
  end

  def update_oauth_tokens(user, auth_hash)
    user.update(
      access_token: auth_hash[:access_token],
      refresh_token: auth_hash[:refresh_token],
      token_expires_at: auth_hash[:expires_at]
    )
  end
end
