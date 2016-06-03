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
      lessons_path # Or :prefix_to_your_route     
  end
    
  protected

  def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up).push(:username)
  end
end 