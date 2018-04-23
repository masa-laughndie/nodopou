require 'test_helper'

class ContactTest < ActiveSupport::TestCase
  
  def setup
    @contact = contacts(:co1)
  end

  test 'should be valid' do
    assert @contact.valid?
  end

  test 'should name not be blank' do
    @contact.name = nil
    assert_not @contact.valid?
  end

  test 'should name less than 101 characters' do
    @contact.name = 'a' * 101
    assert_not @contact.valid?
  end

  test 'should email not be blank' do
    @contact.email = nil
    assert_not @contact.valid?
  end

  test 'should email not user invalid charcters' do
    @contact.email = "invalid.com"
    assert_not @contact.valid?
  end

  test 'should email less than 256 characters' do
    @contact.email = 'a' * 244 + '@example.com'
    assert_not @contact.valid?
  end
  test 'should content not be blank' do
    @contact.content = nil
    assert_not @contact.valid?
  end

  test 'should content less than 2001 characters' do
    @contact.content = 'a' * 2001
    assert_not @contact.valid?
  end


end
