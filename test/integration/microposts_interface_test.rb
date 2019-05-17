require 'test_helper'

class MicropostsInterfaceTest < ActionDispatch::IntegrationTest
	def setup
		@user = users(:sagar)
		@other_user = users(:ram)

		@micropost = microposts(:orange)
		@other_micropost = microposts(:apple)
	end

    test "micropost interface" do
    	log_in_as(users(:shikhar))
    	get root_path
    	assert_match "0 micropost", response.body
	    log_in_as(@user)
	    get root_path
	    assert_select "div.pagination"
	    assert_select "input[type=file]"
	    #correct number for microposts is displayed
	    assert_match "#{@user.microposts.count} microposts", response.body

	    # invalid micropost submission
	    assert_no_difference 'Micropost.count' do 
	    	post microposts_path(@user, params: {micropost: {content: ''}})
	    	post microposts_path(@user, params: {micropost: {content: 'a'*141}})
	    end
	    assert_select '.alert.alert-danger' do 
	    	post microposts_path(@user, params: {micropost: {content: ''}})
	    end
		# valid submission
		picture = fixture_file_upload('test/fixtures/kitten.jpg', 'image/jpg')
		assert_difference 'Micropost.count', 1 do 
			post microposts_path(@user, params: {micropost: {content: 'lorem ipsum', picture: picture}})
		end
		assert_redirected_to root_url
		# delete post
		assert_no_difference 'Micropost.count' do 
			delete micropost_path(@other_micropost)
		end
		assert_difference 'Micropost.count', -1 do
			delete micropost_path(@micropost)
		end
		# visit different user (no delete link)
		get user_path(@other_user)
		assert_select 'a', text: 'delete', count: 0
    end
end
