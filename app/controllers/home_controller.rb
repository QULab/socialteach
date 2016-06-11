class HomeController < ApplicationController
    
  include ApplicationHelper
    
  def index
    if user_signed_in?
        
        redirect_to course_custom_page_path 
  	else 
  		redirect_to new_user_session_path
  	end
  end
end
