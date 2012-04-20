class SessionsController < ApplicationController

	def new
		@title = 'Sign in'
	end

	def create
		@title = 'Create'
		user = User.find_by_email(params[:session][:email])
		if user && user.authenticate(params[:session][:password])
			sign_in user
			redirect_to user
			# Sign in the user and redirect to user's show page
		else
			flash.now[:error] = "Invalid email/password combination"
			render 'new'
			# Create an error message and re-render the signin form
		end
	end

	def destroy
	end
end
