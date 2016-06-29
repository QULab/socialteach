class HomeController < ApplicationController

  include ApplicationHelper


  def index
    if user_signed_in?
    	add_breadcrumb "Home", root_path()
        render :index
  	else
  		redirect_to new_user_session_path
  	end
  end
end
