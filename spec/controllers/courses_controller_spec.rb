require 'rails_helper'

RSpec.describe CoursesController, type: :controller do

    describe "User" do
      login_user
    
      it "should not have an new course button" do
        should !have_link('New Course', href: new_course_path)    
      end      
    end
end
