require 'rails_helper'

RSpec.describe HomeController, type: :controller do
<<<<<<< HEAD

  describe "Login Process" do
    login_user

    it "should have a current_user" do
      # note the fact that you should remove the "validate_session" parameter if this was a scaffold-generated controller
      expect(subject.current_user).to_not eq(nil)
    end
    
    it "should get custom_page after login" do
      # Note, rails 3.x scaffolding may add lines like get :index, {}, valid_session
      # the valid_session overrides the devise login. Remove the valid_session from your specs
      get 'index'
        expect(response).to redirect_to(course_own_courses_path)  
        
    end      
end
