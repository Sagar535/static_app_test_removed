require 'rails_helper'

RSpec.describe RelationshipsController, type: :controller do
	let(:follower) { create(:user) }
	let(:following) { create(:user) }
	let(:relationship) { create(:relationship, follower: follower, following: following) }
	let(:following_id) { { following_id: following.id } }
	let(:follower_id) { { follower_id: follower.id } }
	let(:follower_session) { { user_id: follower.id } }

	describe 'POST #create' do 
		context "when user follows another user without ajax" do
			it "should increase relationships" do
			end

			it "should redirect to the follower user" do 
			end
		end

		context "when user follows another user with ajax request" do
			it "should increase relationships" do
			end

			it "should render the js template" do 
			end
		end
	end

	describe 'DELETE #destroy' do 
		context "when user unfollows another user without ajax" do
			it "should decrease relationships" do
			end

			it "should redirect to the unfollowed user" do 
			end
		end

		context "when user unfollows another user with ajax request" do 
			it "should decrease relationships" do
			end

			it "should render the js tempate" do 
			end
		end
	end
end
