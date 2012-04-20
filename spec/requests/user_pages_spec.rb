require 'spec_helper'

describe "UserPages" do
	subject { page }
	base_title = 'Ruby on Rails Tutorial Sample App'
 	
	describe "Signup page" do
    	before { visit signup_path }

    	it { should have_selector 'h1', text: 'Sign up' }
    	it { should have_selector 'title', text: full_title('Sign up') }
    end

    describe "profile page" do
    	let(:user) { FactoryGirl.create(:user) }
    	before { visit user_path(user) }

    	it { should have_selector 'h1', text: user.name }
    	it { should have_selector 'title', text: user.name }
    end

    describe "signup" do
        before { visit signup_path }
        describe "with invalid information" do
            it "should not create a user" do
                expect { click_button "Create my account" }.not_to change(User, :count)
            end
        end

        describe "with valid infomration" do
            before do
                fill_in "Name",         with: "Example User"
                fill_in "Email",        with: "user@example.com"
                fill_in "Password",     with: "foobar"
                fill_in "Confirmation", with: "foobar"
            end

            it "should create a user" do
                expect { click_button "Create my account" }.to change(User, :count)
            end
        end
    end

    describe "edit" do
        let (:user) { FactoryGirl.create(:user)}
        before { visit edit_user_path(user) }

        describe "page" do
            it { should have_selector('h1',     text: "Update your profile") }
            it { should have_selector('title',  text: "Edit user") }
            it { should have_link('change', href: 'http://gravatar.com/emails')}    
        end
        
        describe "with invalid information" do
            before { click_button "Save changes" }
            it { should have_content('error') }
        end        
    end
end
