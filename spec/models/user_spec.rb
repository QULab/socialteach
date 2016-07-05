require 'rails_helper'

RSpec.describe User, type: :model do
    
    it "user has correct attributes" do
      user = User.create!(username: "Andy", email: "andy@web.de", password:"123456", is_instructor: true)

      expect(user.username).to eq("Andy")
      expect(user.is_instructor).to eq(true)
      expect(user.id).to eq(1)
      
  end
end
