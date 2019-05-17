require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
	test "full title helper" do
		assert_equal full_title, "Static Page"
		assert_equal full_title("Help"), "Help | Static Page"
	end
end
