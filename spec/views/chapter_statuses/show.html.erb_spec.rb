require 'rails_helper'

RSpec.describe "chapter_statuses/show", type: :view do
  before(:each) do
    @chapter_status = assign(:chapter_status, ChapterStatus.create!(
      :skip => false,
      :course_enrollment => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/false/)
    expect(rendered).to match(//)
  end
end
