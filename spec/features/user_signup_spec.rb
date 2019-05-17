require 'rails_helper'

RSpec.feature "UserSignups", type: :feature do
  let(:user) { create(:user) }
  let(:valid_params) { build(:user).attributes.merge(password: 'gaggag') }

  scenario "able to see the signup form" do 
  	visit('/signup')
  end

  scenario "able to signup" do 
  	visit('/signup')
  	fill_in "user_name", :with => "Random user"
  	fill_in "user_email", :with => "random@example.com"
  	fill_in "user_password", :with => "gaggag"
  	fill_in "user_password_confirmation", :with => "gaggag"

  	click_button "Submit"

  end

  context "when invalid credentials" do 
  	scenario "signup fail" do 
  		visit('/signup')
  		click_button "Submit"
  	end
  end
end
