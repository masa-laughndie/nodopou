ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def is_logged_in?
    !session[:msuid].nil?
  end

  def log_in_as(user)
    session[:msuid] = user.id
  end
end

class ActionDispatch::IntegrationTest

  def log_in_as(user, password: 'password')
    post login_path, params: { mysize_id: user.mysize_id,
                               password:  password }
  end
end