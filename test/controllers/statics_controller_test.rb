require 'test_helper'

class StaticsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @base_title = "nodobotoke -NotToDoリスト-"
  end

  test "should get home" do
    get root_path
    assert_response :success
    assert_select 'title', "#{@base_title}"
  end

  test "should get terms" do
    get terms_path
    assert_response :success
    assert_select 'title', "利用規約｜#{@base_title}"
  end

  test "should get privacy" do
    get privacy_path
    assert_response :success
  end

  test "should get about" do
    get about_path
    assert_response :success
  end

  test "should get help" do
    get help_path
    assert_response :success
  end

end
