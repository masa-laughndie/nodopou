require 'test_helper'

class AdminsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @admin = users(:admin)
    log_in_as @admin
  end

  test "should get index" do
    get admins_url
    assert_response :success
  end

end
