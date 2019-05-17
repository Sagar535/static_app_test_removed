require 'rails_helper'
require './test/test_helper'
# reqjuire

RSpec.describe UsersController, type: :controller do 
	# users with admin privilege
	let(:super_user) { create(:user, :super) }

	let (:another_super_user) { create(:user, :super) }

	# user without admin privilege
	let(:shikhar) { create(:user) }

	# valid seesion for shikhar
	let(:valid_session) { { user_id: shikhar.id } }

	# valid admin session
	let(:admin_session) { { user_id: super_user.id } }

	#valid user parameters 
	 let (:valid_params) do
       {
           user: {
                   name: 'sagar',
                   email: 'gag@gag.gag',
                   password: 'gaggag',
                   password_confirmation: 'gaggag'
           }
       }
   end

	# invalid user parameters
	let (:invalid_params) { { user: build(:user, email: '').attributes } }


	describe "GET #new" do 
		it "should get new" do 
			get :new
			expect(response).to be_successful
		end
	end

	describe "GET #index" do 
		it "should not allow non logged in user to access" do 
		end

		it "should allow logged in user to access" do 
		end
	end

	describe "GET #show" do 
		it "should get show" do 
			get :show, params: { id: shikhar.id }
			expect(response).to be_successful
		end
	end

	describe "GET #edit" do 
		it "returns a success response for logged in user" do
		end

		it "returns a fail response for non logged in user" do 
		end
	end

	describe "POST #create" do 
		before (:all) do 
			ActionMailer::Base.deliveries.clear
		end

		context "with valid params" do 
			it "should create a user on sign up" do
			end

			it "should redirect to root path" do 
			end

			it "should send a mail to user" do
			end
		end

		context "with invalid params" do 
			it "should redirect to sign up page" do 
			end
		end
	end

	describe "PUT #update" do 
		context "when user is not logged in" do 
			it "should redirect to login page" do 
				put :update, params: {
					id: shikhar.id,
					user: {
						name: 'Sagar',
						email: 's@example.com'
					}
				}
				# expect ........
			end
		end

		context "when user is not correct" do 
			it "should redirect to root_url" do 
			end

			it "should not allow the admin attribute to be edited via the web" do
			end
		end

		context "when params are invalid" do 
			it "should render edit page" do 
			end
		end

		context "when everything is well" do 
			it "should redirect to the user" do 
			end
		end
	end

	describe "DELETE #destroy" do 
		context "when user is not admin" do 
			it "should not allow the user to delete" do
			end
		end

		context "when user is admin" do 
			it "should not allow to delete other admin" do 
			end

			it "should delete other user" do 
			end
		end
	end
end 
