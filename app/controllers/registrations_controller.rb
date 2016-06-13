class RegistrationsController < Devise::RegistrationsController
  
  before_filter :configure_permitted_parameters
    
  def new
    super
  end

  def create
    # add custom create logic here
      super
  end

  def update
    super
  end
    
  # redirect page after successful sign up    
  def after_sign_up_path_for(resource)
      
      if !current_user.is_instructor?
          
        courses_path # acutally redirect to the user_page 
      else 
        course_custom_page_path # redirect to instructor_page
      end
  end
    
  protected

  def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up).push(:username)
      devise_parameter_sanitizer.for(:sign_up).push(:is_instructor)
  end
end 
