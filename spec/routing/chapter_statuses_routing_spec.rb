require "rails_helper"

RSpec.describe ChapterStatusesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/chapter_statuses").to route_to("chapter_statuses#index")
    end

    it "routes to #new" do
      expect(:get => "/chapter_statuses/new").to route_to("chapter_statuses#new")
    end

    it "routes to #show" do
      expect(:get => "/chapter_statuses/1").to route_to("chapter_statuses#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/chapter_statuses/1/edit").to route_to("chapter_statuses#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/chapter_statuses").to route_to("chapter_statuses#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/chapter_statuses/1").to route_to("chapter_statuses#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/chapter_statuses/1").to route_to("chapter_statuses#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/chapter_statuses/1").to route_to("chapter_statuses#destroy", :id => "1")
    end

  end
end
