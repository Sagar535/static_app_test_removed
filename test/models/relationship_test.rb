require 'test_helper'

class RelationshipTest < ActiveSupport::TestCase
	def setup
		@user1 = users(:sagar)
		@user2 = users(:shikhar)
		@relationship = Relationship.new(follower_id: @user1.id, following_id: @user2.id)
	end

	# relationships should be valid
	test "should be valid" do 
		assert @relationship.valid?
	end
	# follower id must exists
	test "follower must exists" do 
		assert @relationship.follower_id
	end
	# following id must exists
	test "followed must exists" do 
		assert @relationship.following_id
	end
end
