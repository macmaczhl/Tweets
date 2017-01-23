# frozen_string_literal: true
FactoryGirl.define do
  factory :user do
    email 'example@example.com'
    provider 'Twitter'
    uid '12345'
    oauth_token '345342asd21'
    oauth_secret '21432d323'

    factory :another_user do
      email '2x@ex.com'
      uid 'fec23r'
    end

    factory :user_with_tweets do
      transient do
        tweets_count 3
      end

      after(:create) do |user, evaluator|
        create_list(:tweet, evaluator.tweets_count, user_id: user.id)
      end
    end
  end
end
