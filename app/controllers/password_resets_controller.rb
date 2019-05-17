class PasswordResetsController < ApplicationController
  before_action :valid_user, :check_expiration, only: [:edit, :update]

  def new
  end

  def create
  	@user = User.find_by(email: params[:password_reset][:email].downcase)
  	if @user
      if @user.activated
    		@user.create_reset_digest
    		@user.send_password_reset_email
    		flash[:info] = "Email sent with password reset instructions"
    		# soon redirect to the password change url
    		redirect_to root_url
      else
        flash[:warning] = "You account is not activated yet, please check your email"
        redirect_to root_url
      end
  	else
  		flash.now[:danger] = "Email address not found"
  		render 'new'
  	end
  end

  def edit
  end

  def update
    @user = User.find_by(email: params[:email])
    if params[:user][:password].empty?
      @user.errors.add(:password, "can't be empty")
      render 'edit'
    elsif @user.update_attributes(user_params)
      log_in @user
      flash[:success] = "Password has been reset"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

  	def valid_user
  		@user = User.find_by(email: params[:email])
  		unless (@user && @user.activated? && 
  				@user.authenticated?(:reset, params[:id]))
  			redirect_to root_url
  		end
  	end

  	def get_user
  		@user = User.find_by(email: params[:email])
  	end

    def check_expiration
      if @user.password_reset_expired?
        flash[:danger] = "Password reset token has expired"
        redirect_to new_password_reset_path
      end
    end
end
