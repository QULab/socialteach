require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #edit_profile" do
    it "returns http success" do
      get :edit_profile
      expect(response).to have_http_status(:success)
    end
  end

end
