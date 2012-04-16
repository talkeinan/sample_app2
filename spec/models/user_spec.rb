# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe User do
	before  { @user = User.new(name: "Example User", email: "user@example.com",
					     password: "secret", password_confirmation: "secret") }
	subject { @user }

	it { should respond_to(:name)  }
	it { should respond_to(:email) }
	it { should respond_to(:password) }
	it { should respond_to(:password_confirmation)}
	it { should respond_to(:password_digest) }
	it { should be_valid }

	describe "when name is not present" do
    	before { @user.name = "" }
    	it { should_not be_valid }
  	end

  	describe "when email is not present" do
		before { @user.email = "" }  		
		it { should_not be_valid }
  	end

  	describe "when name is too long" do
  		before { @user.name = 'a' * 51 }
		it { should_not be_valid } 
  	end

  	describe "when email format is invalid" do
    	invalid_addresses =  %w[user@foo,com user_at_foo.org example.user@foo.]
    	invalid_addresses.each do |invalid_address|
      	before { @user.email = invalid_address }
      		it { should_not be_valid }
    	end	
  	end

  	describe "when email format is valid" do
    	valid_addresses = %w[user@foo.com A_USER@f.b.org frst.lst@foo.jp a+b@baz.cn]
    	valid_addresses.each do |valid_address|
      	before { @user.email = valid_address }
      		it { should be_valid }
    	end
  	end

  	describe "when email address is already taken " do
  		before do
  			duplicate_user = @user.dup
  			duplicate_user.email = @user.email.upcase
  			duplicate_user.save
  		end
  		it { should_not be_valid }
  	end
	
	describe "when password is not present" do
  		before { @user.password = @user.password_confirmation = " " }
  		it { should_not be_valid }
	end

	describe "when password doesn't match confirmation" do
  		before { @user.password_confirmation = "mismatch" }
  		it { should_not be_valid }
	end

	describe "when password confirmation is nil" do
  		before { @user.password_confirmation = nil }
  		it { should_not be_valid }
	end

  	describe "with a password that's too short" do
    	before { @user.password = @user.password_confirmation = "a" * 5 }
    	it { should be_invalid }
  	end

end