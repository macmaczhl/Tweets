# frozen_string_literal: true
FactoryGirl.define do
  factory :tweet do
    url 'example://url'

    factory :user_tweet do
      user
    end
  end
end
