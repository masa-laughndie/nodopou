require 'test_helper'

class MylistsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:ac1)
    log_in_as @user
  end

  test "should get index" do
    get mylists_user_path(@user)
    assert_response :success
  end

  test "should get show" do
    get mylist_user_path(@user, @user.mylists.first)
    assert_response :success
  end

end
