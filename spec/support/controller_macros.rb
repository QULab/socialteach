# spec/support/controller_macros.rb
module ControllerMacros

  def login_instructor
    before(:each) do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        sign_in FactoryGirl.create(:user)
    end
  end
    
  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryGirl.create(:user)
      user.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
      sign_in user
    end
  end

end