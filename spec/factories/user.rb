# frozen_string_literal: true
FactoryGirl.define do
  factory :user do
    email 'example@example.com'
    provider 'Twitter'
    uid '12345'

    factory :another_user do
      email '2x@ex.com'
    end
  end
end
