require 'test_helper'

class UserSettingTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:ac1)
    log_in_as(@user)
  end

  test "edit user some info" do
    #nameまたはaccount_idが空 => 失敗
    get setting_path
    assert_template 'users/edit'
    patch setting_path, params: { user: { name: "",
                                          account_id: "abcdef" } }
    assert_select 'div.error'
    assert_template 'users/edit'
    patch setting_path, params: { user: { name: "ABC",
                                          account_id: "" } }
    assert_select 'div.error'
    assert_template 'users/edit'
    #成功
    patch setting_path, params: { user: { name: "ABC",
                                          account_id: "abcdef" } }
    assert_not flash.empty?
    assert_redirected_to setting_path
  end

  test "edit user email info" do
    get setting_path
    #アドレスが空 => 失敗
    patch email_setting_path, params: { user: { email: "",
                                                is_send_email: true } }
    assert_select 'div.error'
    @user.reload
    assert_not @user.is_send_email == true
    #アドレス「@example.com」が含まれる => 失敗
    patch email_setting_path, params: { user: { email: "account1@example.com",
                                                is_send_email: true } }
    assert_not flash.empty?
    assert_select 'div.flash-danger'
    @user.reload
    assert_not @user.is_send_email == true
    #成功
    patch email_setting_path, params: { user: { email: "account1@gmail.com",
                                                is_send_email: true } }
    assert_not flash.empty?
    assert_redirected_to setting_path
    @user.reload
    assert @user.is_send_email == true
  end

end
