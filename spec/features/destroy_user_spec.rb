require 'rails_helper'

RSpec.feature "DestroyUsers", type: :feature do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:super_user) { create(:user, :super) }

  before do
  	login(current_user, 'gaggag')

  	other_user
  	visit '/users'
  end
  context "when admin visits" do
	let(:current_user) { super_user }
  	scenario "shows the delete" do
  	end
  	scenario "deletes the user" do 
  	end
  end

  context "when normal user visits" do
	let(:current_user) { user }
  	scenario "won't shows the delete" do
  	end
  end
end
