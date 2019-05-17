require 'rails_helper'

RSpec.feature "UserVisitHomes", type: :feature do
  let(:user) { create(:user) }
  let(:post) { create(:micropost, user: user) }

  scenario "able to see the home page by non logged in user" do 
  	visit('/')
  end

  scenario "able to see the feeds by logged in user" do
  	user 
  	post

  	login(user, 'gaggag')
  	visit('/')
  end
end
