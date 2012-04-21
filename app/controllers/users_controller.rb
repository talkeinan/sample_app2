class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update, :index]
  before_filter :correct_user,   only: [:edit, :update]

  def new
  	@title = "Sign up"
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
  	@title = User.find(params[:id]).name
  end

  def index
  	@users = User.paginate(page: params[:page])
  	@title = "All users"
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
  end

  def update
  	@title = "Update user"
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
  	def signed_in_user
      store_location
      redirect_to signin_path, notice: "Please sign in." unless signed_in?
    end

    def correct_user
    	@user = User.find(params[:id])
    	redirect_to(root_path) unless current_user?(@user)
    end

end
