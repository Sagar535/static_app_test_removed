require 'test_helper'

class RelationshipsControllerTest < ActionDispatch::IntegrationTest
  # create should require logged-in user
  # test "create should require logged-in user" do 
  # 	assert_no_difference 'Relationship.count' do 
  # 		post relationships_path
  # 	end
  # 	assert_redirected_to login_url
  # end

  # # destroy should require logged-in user
  # test "destroy should require logged-in user" do 
  # 	assert_no_difference 'Relationship.count' do 
  # 		delete relationship_path(relationships(:one))
  # 	end
  # 	assert_redirected_to login_url
  # end
end
