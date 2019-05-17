require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
	test "layout links" do 
		get root_path
		assert_template 'static_pages/home'
		assert_select "a[href=?]", root_path, count: 2
		assert_select "a[href=?]", helf_path
		assert_select "a[href=?]", about_path, count: 1
		assert_select "a[href=?]", contact_path, count: 1

		@user = users(:sagar)
		log_in_as(@user)
		follow_redirect!
		assert_select "a[href=?]", users_path
		assert_select "a[href=?]", user_path(@user)
		assert_select "a[href=?]", logout_path
		assert_select "a[href=?]", edit_user_path(@user)
	end

	test "signup links" do
		get signup_path

		assert_template 'users/new'
		assert_select "title", full_title("Sign Up")
	end
end
