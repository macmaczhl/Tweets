require 'rails_helper'

RSpec.describe "tweets/edit", type: :view do
  before(:each) do
    @tweet = assign(:tweet, Tweet.create!(
      :text => "MyString",
      :image => "MyString"
    ))
  end

  it "renders the edit tweet form" do
    render

    assert_select "form[action=?][method=?]", tweet_path(@tweet), "post" do

      assert_select "input#tweet_text[name=?]", "tweet[text]"

      assert_select "input#tweet_image[name=?]", "tweet[image]"
    end
  end
end
