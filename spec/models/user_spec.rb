require 'spec_helper'

describe User do

  before do
  	 @user = User.new(name: "Test User", email: "user@test.com",
  										password: "test_pass", password_confirmation: "test_pass") 
  end

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

  it { should be_valid }

  context "when name is not present" do
		before { @user.name = "" }
		it { should_not be_valid }		
  end

  context "when email is not present" do
		before { @user.email = "" }
		it { should_not be_valid }		
  end

  context "when name is too long" do
		before { @user.name = "a" * 51 }
		it { should_not be_valid }		
  end

  context "when email format is invalid" do
		it "should be invalid" do
			addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
			addresses.each do |invalid_address|            
				@user.email = invalid_address
				expect(@user).to be_invalid
			end
		end
  end

  context "when email format is valid" do
		it "should be valid" do
			addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
			addresses.each do |invalid_address|            
				@user.email = invalid_address
				expect(@user).to be_valid
			end
		end
  end

  context "when email address is already taken" do
		before do
			user_with_same_email = @user.dup
			user_with_same_email.email = @user.email.upcase
			user_with_same_email.save
		end

		it { should_not be_valid }
  end

  context "email address with mixed case" do
		let(:mixed_email) { "Test@TesTOVeXampLe.CoM" }

		it "should be saved as lower-case" do
			@user.email = mixed_email
			@user.save
			expect(@user.reload.email).to eq mixed_email.downcase
		end
  end

  context "when password not present" do
		before do
		 	@user = User.new(name: "Test User", email: "user@test.com",
  										 password: "", password_confirmation: "") 
		end
		
		it { should_not be_valid }
  end

  context "when password_confirmation missmatch" do
		before { @user.password_confirmation = "missmatch" }		
		it { should_not be_valid }
  end

  context "with a password that's too short" do
		before { @user.password = @user.password_confirmation = "a" * 5 }
		it { should be_invalid }
  end

  context "return a value of authentication method" do
		before { @user.save }
		let(:founded_user) { User.find_by(email: @user.email) }

		context "with valid password" do
			it { should eq founded_user.authenticate(@user.password) }
		end

		context "with invalid password" do
			let(:user_for_invalid_password) { founded_user.authenticate("invalid") }

			it { should_not eq user_for_invalid_password }
			specify { expect(user_for_invalid_password).to be_false }
		end
  end
end
