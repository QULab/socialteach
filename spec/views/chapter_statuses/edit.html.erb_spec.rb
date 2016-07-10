require 'rails_helper'

RSpec.describe "chapter_statuses/edit", type: :view do
  before(:each) do
    @chapter_status = assign(:chapter_status, ChapterStatus.create!(
      :skip => false,
      :course_enrollment => nil
    ))
  end

  it "renders the edit chapter_status form" do
    render

    assert_select "form[action=?][method=?]", chapter_status_path(@chapter_status), "post" do

      assert_select "input#chapter_status_skip[name=?]", "chapter_status[skip]"

      assert_select "input#chapter_status_course_enrollment_id[name=?]", "chapter_status[course_enrollment_id]"
    end
  end
end
