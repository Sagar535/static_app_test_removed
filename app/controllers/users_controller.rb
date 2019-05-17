class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :index]
  before_action :correct_user?, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    store_location
    @title = "Users"
    @users = User.paginate(page: params[:page])
  end

  def new
  	@title = "Sign Up"

  	@user = User.new
  end

  def show
    @user = User.find(params[:id])
    @title = @user.name
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    #   log_in @user
  		# flash[:success] = "Welcome to the Static page app!"
  		# redirect_to @user
  	else
  		render 	'new'
  	end
  end

  def edit 
    @user = User.find(params[:id])
    @title = @user.name.capitalize
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
        flash[:success] = "The user details are updated successfully"
        redirect_to @user
    else 
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    if (@user != current_user && !@user.admin?)
      User.find(params[:id]).destroy
      flash[:success] = "User deleted"
    else
      flash[:danger] = "Can't delete user with admin privilege"
    end
    redirect_back_or users_url
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in"
      redirect_to login_url
    end
  end

  def correct_user?
    @user = User.find(params[:id])
    unless current_user == @user
      redirect_to root_url
    end
  end

  def admin_user
    unless current_user.admin?
      flash[:danger] = "You are not authorized"
      redirect_back_or root_url
    end 
  end

  def following 
    if logged_in?
      @title = "Following"
      @user = User.find(params[:id])
      @users = @user.following.paginate(page: params[:page])
      render 'show_follow'
    else
      redirect_to login_path
    end
  end

  def followers
    if logged_in?
      @title = "Followers"
      @user = User.find(params[:id])
      @users = @user.followers.paginate(page: params[:page])
      render 'show_follow'
    else 
      redirect_to login_path
    end
  end

  private

	  def user_params
	  	params.require(:user).permit(:name, :email, :password, :password_confirmation)
	  end
end
