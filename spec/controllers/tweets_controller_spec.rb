# frozen_string_literal: true
require 'rails_helper'

RSpec.describe TweetsController, type: :controller do
  let(:user) { create(:user_with_tweets) }

  describe 'GET #index' do
    context 'when authorized user' do
      before do
        sign_in user
        get :index, params: { id: user.id }
      end

      it 'has a 200 status' do
        expect(response).to have_http_status(:success)
      end

      it 'builds new tweet' do
        expect(assigns(:tweet).new_record?).to be true
      end

      it 'loads user tweets' do
        expect(assigns(:tweets).count).to eq(user.tweets.count)
      end

      it 'orders user tweets by created_at' do
        last_tweet = user.tweets.last
        last_tweet.update(created_at: Time.current + 5.seconds)
        expect(assigns(:tweets)).to eq(user.tweets.order(created_at: :desc))
      end
    end

    context 'when anonymous user' do
      it 'redirects to root' do
        get :index, params: { id: user.id }
        expect(response).to redirect_to root_path
      end
    end
  end
end
