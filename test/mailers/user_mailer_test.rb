require 'test_helper'

class UserMailerTest < ActionMailer::TestCase

  def setup
    @user = users(:ac1)
  end

  test "email_update" do
    mail = UserMailer.email_update(@user)
    mail.transport_encoding = "8bit"
    assert_equal "メールアドレスを更新しました。",      mail.subject
    assert_equal ["noreply@nodobotoke.net"],  mail.from
    assert_equal [@user.email],               mail.to
    # assert_match CGI.escape(user_url(@user)), mail.body.encoded
  end

  test "password_reset" do
    mail = UserMailer.password_reset(@user)
    mail.transport_encoding = "8bit"
    assert_equal "仮ログインURL発行",        mail.subject
    assert_equal ["noreply@nodobotoke.net"],  mail.from
    assert_equal [@user.email],               mail.to
    # assert_match "Hi", mail.body.encoded
  end

  test "list_check_notice" do
    mail = UserMailer.list_check_notice(@user)
    mail.transport_encoding = "8bit"
    assert_equal "リストふりかえり通知",             mail.subject
    assert_equal ["noreply@nodobotoke.net"],  mail.from
    assert_equal [@user.email],               mail.to
    # assert_match "Hi", mail.body.encoded
  end

end
