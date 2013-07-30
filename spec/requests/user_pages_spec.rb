require 'spec_helper'

describe "User pages" do

	subject { page }
	
  context "signup page" do
		before { visit signup_path }

		it { should have_content 'Sign up' }
		it { should have_title full_title('Sign up') }
  end

  context "profile page" do
  	let(:user) { FactoryGirl.create(:user) }

		before { visit user_path(user) }

		it { should have_content(user.name) }
		it { should have_title(user.name) }
  end

  context "signup" do
		before { visit signup_path }

		let(:submit) { "Create my account" }

		context "with invalid information" do
		
			it "should not create user" do
				expect { click_button submit }.not_to change(User, :count)
			end
		end

		context "with valid information" do
			
			before do
				fill_in "Name",					:with => "test_user"
				fill_in "Email",				:with => "mail@test.com"
				fill_in "Password",			:with => "test_pass"
				fill_in "Confirmation", :with => "test_pass"
			end

			it "should create a user" do
				expect { click_button submit }.to change(User, :count)
			end
		end
  end
end
