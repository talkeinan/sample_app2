class UsersController < ApplicationController
  	before_filter :signed_in_user, only: [:edit, :update, :index]
  	before_filter :correct_user,   only: [:edit, :update]
  	before_filter :admin_user,     only: :destroy

	def new
	  	@title = "Sign up"
	  	@user = User.new
	end

	def show
		@user = User.find(params[:id])
	  @title = User.find(params[:id]).name
    @microposts = @user.microposts.paginate(page: params[:page])
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

  	def destroy
    	user = User.find(params[:id]).destroy
    	flash[:success] = "User #{user.name} destroyed."
    	redirect_to users_path
  	end

    def toggle_approve  
 		  @user = User.find(params[:id])  
  		@user.toggle!(:admin)
  		flash[:success] = "User #{@user.name} admin status was set to #{@user.admin?}"  
  		
      if request.xhr?
        render partial: 'toggle_admin', locals: { user: @user }
      else
        redirect_to users_path
      end
	  end  

  	private

    def correct_user
    	@user = User.find(params[:id])
    	redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
    	redirect_to(root_path) unless current_user.admin?
    end
end
