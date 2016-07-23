require 'rails_helper'

RSpec.describe "course_badges/edit", type: :view do
  before(:each) do
    @course_badge = assign(:course_badge, CourseBadge.create!(
      :badge => "MyString",
      :description => "MyString"
    ))
  end

  it "renders the edit course_badge form" do
    render

    assert_select "form[action=?][method=?]", course_badge_path(@course_badge), "post" do

      assert_select "input#course_badge_badge[name=?]", "course_badge[badge]"

      assert_select "input#course_badge_description[name=?]", "course_badge[description]"
    end
  end
end
