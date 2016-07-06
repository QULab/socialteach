require 'rails_helper'

RSpec.describe "friendships/show", type: :view do
  before(:each) do
    @friendship = assign(:friendship, Friendship.create!(
      :user_id => 2,
      :friend_id => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
  end
end
