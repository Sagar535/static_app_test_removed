require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
	def setup
		@user = users(:sagar)
	end

  test 'unsuccessful login with invalid credential' do
  	get login_path
  	assert_template 'sessions/new'
  	post login_path, params: {session: {email: 'example@railstutorial.com', password: 'gggggg'}}
  	assert_template 'sessions/new'
  	assert_not flash.empty?
  	assert_select 'div.alert.alert-danger'
  	get root_path
  	assert flash.empty? 
  end

  test 'successful login with valid credential followed by logout' do
  	post login_path, params: {session: {email: 'sagar@example.com', password: 'gaggag'}}
    assert is_logged_in?
  	assert_redirected_to @user
  	follow_redirect!
  	assert_template 'users/show'
  	assert_select 'a[href=?]', login_path, count: 0
  	assert_select 'a[href=?]', logout_path
  	assert_select 'a[href=?]', user_path(@user)

    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_path
# simulate logout click in second window
    delete logout_path
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end

  test "login with remembering" do
    log_in_as(@user)
    assert_not_empty cookies['remember_token']
    assert_equal cookies['remember_token'], assigns(:user).remember_token
  end

  test "login without remembering" do
    log_in_as(@user)
    log_in_as(@user, remember_me: '0')
    assert_empty cookies['remember_token']
  end
end
