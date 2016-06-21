# spec/support/controller_macros.rb
module ControllerMacros

  def login_user
    before(:each) do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        sign_in FactoryGirl.create(:user)
    end
  end
    
  def login_instructor
    before(:each) do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        sign_in FactoryGirl.create(:user_instructor)
    end
  end

end