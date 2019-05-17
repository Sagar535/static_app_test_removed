require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
		@user = users(:sagar)
	end

	test 'unsuccessful edit with invalid inputs' do
		log_in_as(@user)
		get edit_user_path(@user)
		assert_template 'users/edit'
		patch user_path(@user), params: { user: {
			name: '', email: '', password: '', password_confirmation: ''
		} }
		assert_template 'users/edit'
		assert_select 'div.alert.alert-danger', text: "The form contains 5 errors"
	end

	test 'successful edit with valid inputs' do
		log_in_as(@user)
		get edit_user_path(@user)
		assert_template 'users/edit'
		patch user_path(@user), params: { user: {
			name: 'ragas', email: 'gag@gag.gag', password: 'gggggg', password_confirmation: 'gggggg'
		}}
		@user.reload
		assert_equal 'ragas', @user.name
		assert_equal 'gag@gag.gag', @user.email

		assert_not flash.empty?
		assert_not flash[:success].empty?
		assert_redirected_to @user
		follow_redirect!
		assert_template 'users/show'
	end

	test "non logged in user can't edit or update" do
		get edit_user_path(@user)
		assert_redirected_to login_url
		patch user_path(@user), params: { user: {
			name: 'ragas',
			email: 'rag@rag.rag',
			password: 'ragrag',
			password_confirmation: 'ragrag'
		} }
		assert_redirected_to login_url
	end

	test "only the user can edit or update his own profile" do
		@other_user = users(:shikhar)
		log_in_as(@other_user)
		get edit_user_path(@user)
		assert_redirected_to root_url

		patch user_path(@user), params: { user: {
			name: 'ragas', email: 'gag@gag.gag', password: 'gggggg', password_confirmation: 'gggggg'
		} }
		assert_redirected_to root_url
	end

	test "friendly forwarding after successful login" do
		get edit_user_path(@user)
		assert_not_nil session[:forwarding_url]
		log_in_as(@user)
		assert_redirected_to edit_user_path(@user)
	end
end
