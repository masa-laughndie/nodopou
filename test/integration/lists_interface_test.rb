require 'test_helper'

class ListsInterfaceTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:ac1)
    @list = lists(:list1)
  end

  test "create list interface" do
    get user_path(@user)
    assert_redirected_to root_path
    log_in_as(@user)
    get user_path(@user)
    content = "Listテスト"
    assert_no_difference 'List.count' do
      post lists_path, params: { list: { content: "" } }
    end

    assert_not flash.empty?
    assert_difference 'List.count', 1 do
      post lists_path, params: { list: { content: content } }
    end
    assert_not flash.empty?
    assert_redirected_to user_path(@user)
    follow_redirect!
    assert_match content, response.body
  end

  test "destroy list interface" do
    log_in_as(@user)
    get user_path(@user)
    assert_difference 'List.count', -1 do
      delete list_path(@list)
    end
    assert_not flash.empty?
    assert_redirected_to user_path(@user)
  end

end
