require 'rails_helper'

RSpec.feature "ProfileViews", type: :feature do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:micropost) { create(:micropost, user: user) }

  before do 
  	micropost
  end

  scenario "able to see the user profile" do 
  end

  context "when user has posts" do 
  	scenario "should sees the microposts" do
  	end
  end

  context "when visitor is logged in" do
  	before do 
  		login(other_user, 'gaggag')
  		visit(user_path(user))
  	end 
  	scenario "should see the follow or unfollow button" do 
  	end

  	context "when visitor follows the user" do 
  		scenario "button changes from follow to unfollow" do 
  		end
  	end

  	context "when visitor unfollows the user" do 
  		scenario "button changes from unfollow to follow" do
  		end
  	end
  end 
end
