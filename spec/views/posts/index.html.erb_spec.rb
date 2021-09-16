require 'rails_helper'

RSpec.describe "posts/index", type: :view do
  current_user = User.first_or_create!(email: 'anthony@gmail.com', password: 'password', password_confirmation: 'password')

  before(:each) do
    assign(:posts, [
      Post.create!(
        title: "Title",
        body: "MyText",
        user: current_user,
        views: 2
      ),
      Post.create!(
        title: "Title",
        body: "MyText",
        user: current_user,
        views: 5
      )
    ])
  end

  it "renders a list of posts" do
    render
    assert_select "tr>td", text: "Title".to_s, count: 2
    assert_select "tr>td", text: "MyText".to_s, count: 2
    assert_select "tr>td", text: current_user.id.to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 1
    assert_select "tr>td", text: 5.to_s, count: 1
  end
end
