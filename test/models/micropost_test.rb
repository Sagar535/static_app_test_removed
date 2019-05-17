require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
  def setup
  	@user = users(:sagar)
  	@micropost = Micropost.new(content: 'lorm emsum', user_id: @user.id)
  	# @micropost = @user.microposts.build(content: "lorem ipsum")
  end

  test "should be valid" do
  	assert @micropost.valid?
  end

  test "user id should be present" do
  	assert @micropost.user_id
  	@micropost.user_id = nil
  	assert_not @micropost.valid?
  end

  test "content should be present" do
  	assert @micropost.content
  	@micropost.content = nil
  	assert_not @micropost.valid?
  	@micropost.content = "   "
  	assert_not @micropost.valid?
  end

  test "content should be at most 140 characters" do
  	@micropost.content = "a" * 141
  	assert_not @micropost.valid?
  end
end
