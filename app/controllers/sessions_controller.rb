class SessionsController < ApplicationController

	def new
		@title = 'Sign in'
	end

	def create
		@title = 'Sign in'
		user = User.find_by_email(params[:session][:email])
		if user && user.authenticate(params[:session][:password])
			# Sign in the user and redirect to user's show page
			sign_in user
			redirect_to user
		else
			# Create an error message and re-render the signin form
			flash.now[:error] = "Invalid email/password combination"
			render 'new'
		end
	end

	def destroy
		@title = 'Sign in'
		sign_out
		redirect_to root_path
	end
end
