require 'rails_helper'

RSpec.describe MicropostsController, type: :controller do
	# normal user
	let(:user) { create(:user) }
	let(:other_user) { create(:user) }

	# sample micropost attributes 
	let(:sample_post_attributes) do
		{
			params: { micropost: { content: 'Lorem ipsum dolor it' } }
		}
	end

	let(:micropost) { create(:micropost, user: user) }

	# sample micropost
	let(:sample_post)  { { params: { micropost: micropost } } }

	describe 'POST #create' do 
		context "non logged in user posts" do
			it "should not create the post" do
			end
		end

		context "logged in user posts" do
			it "should create the post" do
			end

			it "should redirect to root url" do 
			end
		end
	end

	describe 'DELETE #destroy' do 
		context "non logged in user" do 
			it "should not change the number of micropost" do
			end
		end
		context "logged in user others micropost" do 
			end
		end
		context "logged in admin" do
			it "should decrease the micropost by 1" do 
			end
		end
	end
end
