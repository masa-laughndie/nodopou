require 'test_helper'

class MylistsInterfaceTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:ac1)
    log_in_as(@user)
    @list = lists(:list3)
    @mylist = mylists(:my1)
  end

  test "should avail a list the standard way" do
    assert_difference '@user.mylists.count', 1 do
      post mylists_path, params: { list_id: @list.id }
    end
  end

  test "should avail a list with Ajax" do
    assert_difference '@user.mylists.count', 1 do
      post mylists_path, xhr: true, params: { list_id: @list.id }
    end
  end

  test "should unavail a list the standard way" do
    assert_difference '@user.mylists.count', -1 do
      delete mylist_path(@mylist.list)
    end
  end

  test "should unavail a list with Ajax" do
    assert_difference '@user.mylists.count', -1 do
      delete mylist_path(@mylist.list), xhr: true
    end
  end

end
