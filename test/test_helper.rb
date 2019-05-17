ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/reporters'
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def log_in_as(user)
  	session[:user_id] = user.id
  end

  # Add more helper methods to be used by all tests here...
  include ApplicationHelper
end

class ActionDispatch::IntegrationTest
	def log_in_as(user, password: 'gaggag', remember_me: '1')
		post login_path, params: {session: {
			email: user.email,
			password: password,
			remember_me: remember_me
		}}
	end
end
