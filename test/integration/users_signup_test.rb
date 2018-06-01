require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post signup_path, params: { user: { account_id: "",
                                          email: "test1@example.com",
                                          password: "foobar" } }
    end
    assert_template 'users/new'
    assert_select 'div.error'
    assert_no_difference 'User.count' do
      post signup_path, params: { user: { account_id: "abc",
                                          email: "",
                                          password: "foobar" } }
    end
    assert_template 'users/new'
    assert_select 'div.error'
    assert_no_difference 'User.count' do
      post signup_path, params: { user: { account_id: "abc",
                                          email: "test1@example.com",
                                          password: "" } }
    end
    assert_template 'users/new'
    assert_select 'div.error'
  end

  test "valid singup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post signup_path, params: { user: { account_id: "abc",
                                          email: "test1@example.com",
                                          password: "foobar" } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
  end
end
