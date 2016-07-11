class UsersController < ApplicationController
	before_action :authenticate_user!, only: [:edit_profil, :update]
  before_action :check_authorization, only: [:edit_profil, :update]
 	before_action :set_user, only: [:show]

  def show

    @socialp = @user.points(category: "Socialpoints")
    @learningp = @user.points(category: "Learningpoints")
    @enrollment_points = @user.course_enrollments.map do |enrollment|
      {:enrollment => enrollment, :points =>enrollment.points(category: "Levelpoints")}
    end

    #delete all nil hashes
    @enrollment_points.compact


  end

  def edit_profil
    @user = User.find(id: current_user.id)
  end

  def update
  	if current_user.update(user_params)
  		redirect_to current_user
  	else
  		flash.now[:alert] = "Something went wrong. Please try again"
  		render :edit
  	end
  end

  private

  	def check_authorization
  		unless current_user.id == params[:id].to_i
  			redirect_to root_url
  		end
  	end

  	def set_user
  		@user= User.find(params[:id])
  	end

  	def user_params
  		params.require(:user).permit(:username, :avatar, :birthday, :aboutme)
  	end

end
