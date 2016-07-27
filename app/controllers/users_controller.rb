class UsersController < ApplicationController
	before_action :authenticate_user!, only: [:edit_profile, :update]
 	before_action :set_user, only: [:show]

  add_breadcrumb "Home", :root_path

  def show
    add_breadcrumb "Profil", user_path()
  end

  def edit_profile
    add_breadcrumb "Edit", users_edit_profile_path()
  end

  def update
  	if current_user.update(user_params)
  		redirect_to current_user
  	else
  		flash.now[:alert] = "Something went wrong. Please try again"
  		render :edit_profile
  	end
  end

  private

  	def set_user
  		@user= User.find(params[:id])
  	end

  	def user_params
  		params.require(:user).permit(:username, :avatar, :birthday, :aboutme)
  	end

end
