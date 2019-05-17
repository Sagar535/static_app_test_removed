require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
	def setup
		@base_title = "Static Page"
	end

  test "should get root" do
  	get root_url

  	assert_response :success
  end

  test "should get home" do
    get root_url

    assert_select "title", full_title("Home")
    assert_response :success
  end

  test "should get help" do
    get helf_path

    assert_select "title", full_title("Help")
    assert_response :success
  end

  test "should get about" do
  	get about_path

  	assert_select "title", full_title("About")
  	assert_response :success
  end

  test "shoud get contact" do
  	get contact_path

  	assert_select "title", full_title("Contact")
  	assert_response :success	
  end

end
