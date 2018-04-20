require 'test_helper'

class ListsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:ac1)
    log_in_as @user
  end
  test "should get index" do
    get lists_path(@user)
    assert_response :success
  end

end
