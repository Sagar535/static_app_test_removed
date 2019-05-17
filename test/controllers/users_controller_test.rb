require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
  	@user = users(:sagar)
  	@other_user = users(:shikhar)
  	@admin = users(:ram)
  	@dummy = users(:user_1)
  end

  test "should get new" do
    get signup_path
    assert_response :success
  end

  test "users list index page not accessed by non logged in users" do
  	get users_path
  	assert_redirected_to login_url
  end

  test "should not allow the admin attribute to be edited via the web" do
  	@other_user = users(:shikhar)
  	log_in_as(@other_user)
  	assert_not @other_user.admin?
  	patch user_path(@other_user), params: {
  		user: {
  			password: 'gaggag',
  			password_confirmation: 'gaggag',
  			admin: true
  		},

  	}
  	assert_not @other_user.reload.admin?
  end

  test "should allow admin to delete only other users" do
  	log_in_as(@user)
  	assert_difference 'User.count', -1 do 
  		delete user_path(@other_user)
  	end
  	# make sure admin can't delete himself
  	assert_difference 'User.count', 0 do 
  		delete user_path(@user)
  	end

  	# make user admin can't delete other admin
  	assert_difference 'User.count', 0 do
  		delete user_path(@admin)
  	end
  end

  test "should not allow non logged in user to delete user" do
  	log_in_as(@other_user)
  	assert_difference 'User.count', 0 do 
  		delete user_path(@user)
  	end
  end

  test "should not allow logged in user with no admin privilege to delete user" do
  	log_in_as(@user)
  	assert_difference 'User.count', 0 do
  		delete user_path(@user)
  	end
  end

  test "shoud redirect following when not logged in" do 
    get following_user_path(@user)
    assert_redirected_to login_url
  end

  test "should redirect followers when not logged in" do 
    get followers_user_path(@user)
    assert_redirected_to login_url
  end
end
