require 'test_helper'

class FollowingTest < ActionDispatch::IntegrationTest
  def setup
  	@user = users(:sagar)
    @other_user = users(:shikhar)
  	log_in_as(@user)
    @user.unfollow(@other_user)
  end
  # following page
  # test following not empty 
  #test number of following display in the response body
  # link present on the page for the following user
  test "following page" do
  	get following_user_path(@user)
  	assert_template 'users/show_follow'
  	assert_not @user.following.empty?
  	assert_match @user.following.count.to_s, response.body
  	@user.following.each do |user| 
  		assert_select "a[href=?]", user_path(user)
  	end
  end
  # follower page
  # test followers not empty
  # test number of followers display in the response body
  test "followers page" do 
  	get followers_user_path(@user)
  	assert_template 'users/show_follow'
  	assert_not @user.followers.empty?
  	assert_match @user.followers.count.to_s, response.body
  	@user.followers.each do |user| 
  		assert_select "a[href=?]", user_path(user)
  	end
  end

  # should follow a user the standard way
  test "should follow a user the standard way" do 
    assert_difference '@user.following.count', 1 do 
      post relationships_path, params: { following_id: @other_user.id }
    end
  end
  # should follow a user with Ajax
  test "should follow a user with ajax" do 
    assert_difference '@user.following.count', 1 do 
      post relationships_path, xhr: true, params: { following_id: @other_user.id }
    end
  end
  # should unfollow a user the standard way
  test "should unfollow a user the standard way" do
    @user.follow(@other_user)
    relationship = @user.active_relationships.find_by(following_id: @other_user.id) 
    assert_difference '@user.following.count', -1 do 
      delete relationship_path(relationship)
    end
  end
  # should unfollow a user with Ajax
  test "should unfollow a user with Ajax" do
    @user.follow(@other_user) 
    relationship = @user.active_relationships.find_by(following_id: @other_user.id)
    assert_difference '@user.following.count', -1 do 
      delete relationship_path(relationship), xhr: true
    end
  end
end
