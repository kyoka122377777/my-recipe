class UserMailer < ApplicationMailer
  def confirmation_email(user)
    @user = user
    @confirmation_link = confirmation_url(confirmation_token: @user.confirmation_token)
    mail(to: @user.email, subject: 'メールアドレスの確認')
  end
end
  