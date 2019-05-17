require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
	describe "GET #home" do 
		it "should return home path with success" do 
			get :home
			expect(response).to be_successful
		end
	end
	describe "GET #help" do 
		it "should return help" do 
			get :help
			expect(response).to be_successful
		end
	end
	describe "GET #about" do 
		it "should return about" do 
			get :about
			expect(response).to be_successful
		end
	end 
	describe "GET #contact" do 
		it "should return contact" do 
			get :contact
			expect(response).to be_successful
		end
	end
end
