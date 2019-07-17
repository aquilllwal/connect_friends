class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :index, :show]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user, only: :destroy
  
  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page])
	end
	
	def new
    @user = User.new
    # render 
	end

	def create
    @user = User.new(user_params)
		if @user.save
			log_in @user
      flash[:success] = "welcome #{@user.username}"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to user_path(@user)
    else
      render "edit"
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def search
    if params[:user].present?
      @search = User.new_from_lookup(params[:user])
      if @search
        respond_to do |format|
          format.js { render partial: 'users/result' }
        end
      else
        flash[:danger] = "No user exist"
        redirect_to goto_users_path
      end
    end
  end

  private

    def user_params
      params.require(:user).permit(:username, :email, :password)
    end

    # to check if correct user is editing or not
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end