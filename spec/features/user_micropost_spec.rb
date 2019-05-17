require 'rails_helper'

RSpec.feature "UserMicroposts", type: :feature do
  let(:user) { create(:user) }
  let(:micropost) { create(:micropost, user: user) }
  let(:valid_params) { build(:micropost, user: user).attributes }

  before do 
  	login(user, 'gaggag')
    visit '/'
    fill_in 'micropost_content', with: params[:content]
    attach_relevant_file if respond_to? :attach_relevant_file
    click_button 'Post'
  end

  context "post with invalid content" do
    context "post with empty content" do
      let(:params) { valid_params.merge("content" => '') }                                                                                                                                
      scenario "sees the error messages" do
    	end
    end

    let(:params) { valid_params }
    context "post with invalid file format" do
      let(:attach_relevant_file) do
        attach_file 'micropost_picture', Rails.root + 'spec/fixtures/languages.csv'
      end      
      scenario "sees the error message" do 
      end
    end

    context "post with large file" do
      let(:attach_relevant_file) do                                                                                                         
        attach_file 'micropost_picture', Rails.root + 'spec/fixtures/invalid.png'
      end
      scenario "sees the error message" do
      end
    end
  end
  
  context "post with valid content" do
    let(:params) { valid_params }
    scenario "sees the success message" do 
  	end
  end
end
