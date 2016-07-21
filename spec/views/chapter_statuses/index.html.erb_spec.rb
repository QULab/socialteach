require 'rails_helper'

RSpec.describe "chapter_statuses/index", type: :view do
  before(:each) do
    assign(:chapter_statuses, [
      ChapterStatus.create!(
        :skip => false,
        :course_enrollment => nil
      ),
      ChapterStatus.create!(
        :skip => false,
        :course_enrollment => nil
      )
    ])
  end

  it "renders a list of chapter_statuses" do
    render
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
