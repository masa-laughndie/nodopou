require 'test_helper'

class PasswordResetTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
    @user = users(:ac1)
  end

  test "password_reset" do
    get new_password_reset_path
    assert_template 'password_resets/new'
    post password_reset_path, params: { email: "" }
    assert_select 'div.flash-danger'
    assert_template 'password_resets/new'
    post password_reset_path, params: { email: @user.email }
    assert_not_equal @user.reset_digest, @user.reload.reset_digest
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_redirected_to confirm_password_reset_path
    user = assigns(:user)
    get login_password_reset_path(rst: user.reset_token, e_token: "")
    assert_redirected_to root_url
    get login_password_reset_path(rst: "", e_token: user.e_token)
    assert_redirected_to root_url
    get login_password_reset_path(rst: user.reset_token, e_token: user.e_token)
    assert_not flash.empty?
    assert_redirected_to setting_path
  end
end
