require 'test_helper'

class MylistTest < ActiveSupport::TestCase
  
  def setup
    @mylist = mylists(:my1)
  end

  test 'should be valid' do
    assert @mylist.valid?
  end

  test 'should require a user_id' do
    @mylist.user_id = nil
    assert_not @mylist.valid?
  end

  test 'should require a list_id' do
    @mylist.list_id = nil
    assert_not @mylist.valid?
  end

end
