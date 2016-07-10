require 'rails_helper'

RSpec.describe "chapter_statuses/new", type: :view do
  before(:each) do
    assign(:chapter_status, ChapterStatus.new(
      :skip => false,
      :course_enrollment => nil
    ))
  end

  it "renders new chapter_status form" do
    render

    assert_select "form[action=?][method=?]", chapter_statuses_path, "post" do

      assert_select "input#chapter_status_skip[name=?]", "chapter_status[skip]"

      assert_select "input#chapter_status_course_enrollment_id[name=?]", "chapter_status[course_enrollment_id]"
    end
  end
end
