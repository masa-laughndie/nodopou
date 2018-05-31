# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at 
  # http://localhost:3000/rails/mailers/user_mailer/email_update
  def email_update
    user = User.first
    UserMailer.email_update(user)
  end

  # Preview this email at 
  # http://localhost:3000/rails/mailers/user_mailer/password_reset
  def password_reset
    user = User.first
    user.reset_token = SecureRandom.uuid
    user.e_token = User.digest(user.email)
    UserMailer.password_reset(user)
  end

  # Preview this email at 
  # http://localhost:3000/rails/mailers/user_mailer/list_check_notice
  def list_check_notice
    user = User.second
    UserMailer.list_check_notice(user)
  end

end
