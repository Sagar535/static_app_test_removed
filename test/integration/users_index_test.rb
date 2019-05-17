require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
  	@user = users(:sagar)
  	@other_user = users(:shikhar)
  end

  test "index as admin with pagination and delete" do 
  	log_in_as(@user)
  	get users_path
  	assert_template 'users/index'
  	assert_select 'div.pagination', count: 2
  	first_page_users = User.paginate(page: 1)
  	first_page_users.each do |user|
      if user.activated?
    		# there must be link to users profile
    		assert_select 'a[href=?]', user_path(user), text: user.name 
    		# assert there are delete buttons next to users but not next to admin
    		unless user.admin?
    			assert_select 'a[href=?]', user_path(user), text: 'delete'
    		else
    			# assert there are no delete buttons next to admins
    			# there can be maximum of 2 links one at profile, one in user name 
    			#but not for delete like in others
    			assert_select 'a[href=?]', user_path(user), text: 'delete', count: 0
    		end
      end
  	end 
  end

  test "index as non admin only pagination no delete" do
    log_in_as(@other_user)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination', count: 2
    first_page_users = User.paginate(page:1)
    first_page_users.each do |user|
      assert_select 'a', text: 'delete', count: 0
    end
  end
end
