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

  def edit
  	@title = "Edit user"
  	@user = User.find(params[:id])
  end

  def update
  	@title = "Update user"
  	@user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

end
