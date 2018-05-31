require 'test_helper'

class ListsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:ac1)
    log_in_as @user
  end

  test 'should get show' do
    get list_path(lists(:list1))
    assert_response :success
  end
  
end
