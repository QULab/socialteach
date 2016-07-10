require 'rails_helper'

RSpec.describe "ChapterStatuses", type: :request do
  describe "GET /chapter_statuses" do
    it "works! (now write some real specs)" do
      get chapter_statuses_path
      expect(response).to have_http_status(200)
    end
  end
end
