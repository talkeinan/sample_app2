require 'spec_helper'

describe "UserPages" do
	subject { page }
	base_title = 'Ruby on Rails Tutorial Sample App'
 	
	describe "Signup page" do
    	before { visit signup_path }

    	it { should have_selector 'h1', text: 'Signup' }
    	it { should have_selector 'title', text: full_title('Sign up') }
    end
end
