require 'test_helper'

class PasswordResetTest < ActionDispatch::IntegrationTest
  def setup 
  	@user = users(:sagar)
  	ActionMailer::Base.deliveries.clear
  end

  test "password reset with email" do
  	get new_password_reset_path
  	assert_template 'password_resets/new'
  	# Invalid email
  	post password_resets_path, params: { password_reset: {email: ""} }
  	assert_not flash.empty?
  	assert_template 'password_resets/new'
  	#Valid email
  	post password_resets_path, params: { password_reset: {email: @user.email }}
  	assert_redirected_to root_path
  	assert_equal 1, ActionMailer::Base.deliveries.size
  	assert_not flash.empty?
  	#Password reset form
  	user = assigns(:user)
  	#Wrong email
  	get edit_password_reset_path(user.reset_token, email: "")
  	assert_redirected_to root_url
  	# Inactive user
  	user.toggle!(:activated)
  	get edit_password_reset_path(user.reset_token, email: user.email)
  	assert_redirected_to root_url
  	assert_not flash.empty?
  	# assert_equal 'You account is not activated yet, please check your email', flash[:warning]
  	user.toggle!(:activated)
  	# Right email, wrong token
  	get edit_password_reset_path('wrong token', email: user.email)
  	assert_redirected_to root_url
  	# Right email, right token
  	get edit_password_reset_path(user.reset_token, email: user.email)
  	assert_template 'password_resets/edit'
  	assert_select 'input[name=email][type=hidden][value=?]', user.email
  	# Invalid password & confirmation
  	patch password_reset_path(user.reset_token),
  		params: {
  			email: user.email,
  			user: {
  				password: 'gaggag',
  				password_confirmation: 'gggggg'
  			}
  		}
	assert_select "div#error_explanation"
	# Valid password & confirmation
	patch password_reset_path(user.reset_token),
		params: {email: user.email,
				user: {
					password: 'gggggg',
					password_confirmation: 'gggggg'
				}
		}
	assert is_logged_in?
	assert_not flash.empty?
	assert_redirected_to user
  end
end
