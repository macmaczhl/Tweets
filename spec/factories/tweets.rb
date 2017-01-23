# frozen_string_literal: true
FactoryGirl.define do
  factory :tweet do
    url 'example://url'
    user
  end
end
