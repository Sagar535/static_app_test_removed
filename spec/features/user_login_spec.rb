require 'rails_helper'

RSpec.feature "UserLogins", type: :feature do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:inactive_user) { create(:user, activated: false) }

  scenario "able to see the login form" do 
  end

  scenario "able to login" do 
  end

  context "when invalid credential" do 
  	scenario "unable to login" do 
  	end
  end

  context "when user account is not activated" do 
    scenario "shuold see check your email address message" do 
    end
  end
end
