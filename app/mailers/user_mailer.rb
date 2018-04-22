class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.email_update.subject
  #
  def email_update(user)
    @user = user
    mail to: user.email, subject: "メールアドレスを更新しました。"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user
    mail to: user.email, subject: "仮ログインURL発行"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.list_check_notice.subject
  #
  def list_check_notice(user)
    @user = user
    @list = @user.lists.where(active: true)
    mail to: user.email, subject: "リストふりかえり通知"
  end
end
