require 'rails_helper'

RSpec.describe "course_badges/index", type: :view do
  before(:each) do
    assign(:course_badges, [
      CourseBadge.create!(
        :badge => "Badge",
        :description => "Description"
      ),
      CourseBadge.create!(
        :badge => "Badge",
        :description => "Description"
      )
    ])
  end

  it "renders a list of course_badges" do
    render
    assert_select "tr>td", :text => "Badge".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
  end
end
