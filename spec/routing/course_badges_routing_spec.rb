require "rails_helper"

RSpec.describe CourseBadgesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/course_badges").to route_to("course_badges#index")
    end

    it "routes to #new" do
      expect(:get => "/course_badges/new").to route_to("course_badges#new")
    end

    it "routes to #show" do
      expect(:get => "/course_badges/1").to route_to("course_badges#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/course_badges/1/edit").to route_to("course_badges#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/course_badges").to route_to("course_badges#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/course_badges/1").to route_to("course_badges#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/course_badges/1").to route_to("course_badges#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/course_badges/1").to route_to("course_badges#destroy", :id => "1")
    end

  end
end
