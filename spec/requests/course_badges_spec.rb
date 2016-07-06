require 'rails_helper'

RSpec.describe "CourseBadges", type: :request do
  describe "GET /course_badges" do
    it "works! (now write some real specs)" do
      get course_badges_path
      expect(response).to have_http_status(200)
    end
  end
end
