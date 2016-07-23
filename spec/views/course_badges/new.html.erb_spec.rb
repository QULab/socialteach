require 'rails_helper'

RSpec.describe "course_badges/new", type: :view do
  before(:each) do
    assign(:course_badge, CourseBadge.new(
      :badge => "MyString",
      :description => "MyString"
    ))
  end

  it "renders new course_badge form" do
    render

    assert_select "form[action=?][method=?]", course_badges_path, "post" do

      assert_select "input#course_badge_badge[name=?]", "course_badge[badge]"

      assert_select "input#course_badge_description[name=?]", "course_badge[description]"
    end
  end
end
