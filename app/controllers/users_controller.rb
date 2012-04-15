class UsersController < ApplicationController
  def new
  	@title = "Sign up"
  end

  def show
  	@user = User.find(params[:id])
  	@title = User.find(params[:id]).name
  end
end
