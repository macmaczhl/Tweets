require 'rails_helper'

RSpec.describe "tweets/new", type: :view do
  before(:each) do
    assign(:tweet, Tweet.new(
      :text => "MyString",
      :image => "MyString"
    ))
  end

  it "renders new tweet form" do
    render

    assert_select "form[action=?][method=?]", tweets_path, "post" do

      assert_select "input#tweet_text[name=?]", "tweet[text]"

      assert_select "input#tweet_image[name=?]", "tweet[image]"
    end
  end
end
