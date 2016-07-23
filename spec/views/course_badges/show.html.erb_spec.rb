require 'rails_helper'

RSpec.describe "course_badges/show", type: :view do
  before(:each) do
    @course_badge = assign(:course_badge, CourseBadge.create!(
      :badge => "Badge",
      :description => "Description"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Badge/)
    expect(rendered).to match(/Description/)
  end
end
