require 'test_helper'

class ListTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:ac1)
    @list = @user.lists.build(content: "テストテストテストテストテスト")
  end

  test 'should be valid' do
    assert @list.valid?
  end

  test 'should require a user_id' do
    @list.user_id = nil
    assert_not @list.valid?
  end

  test 'should require a content' do
    @list.content = "   "
    assert_not @list.valid?
  end

  test 'content should be present less than 101 characters' do
    @list.content = "a" * 101
    assert_not @list.valid?
  end
  
end
