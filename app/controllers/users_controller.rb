class UsersController < ApplicationController
  def new
  	@title = "Sign up"
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
  	@title = User.find(params[:id]).name
  end

  def create
  	@user = User.new(params[:user])
  	@title = "Create"
  	if @user.save
      sign_in @user
  		flash[:success] = "Welcome to the Sample App!"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end
end
