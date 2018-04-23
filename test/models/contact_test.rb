require 'test_helper'

class ContactTest < ActiveSupport::TestCase
  
  def setup
    @contact = contacts(:co1)
  end

  test 'should be valid' do
    assert @contact.valid?
  end
end
