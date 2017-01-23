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

  describe '#resource_name' do
    let(:correct_hash) { { resource_name: I18n.t(:tweet) } }

    it 'returns correct hash' do
      result = controller.__send__(:resource_name)
      expect(result).to eq correct_hash
    end
  end

  let(:resource_name) { 'resource' }
  let(:flash_create_notice) { I18n.t('flash.actions.create.notice', resource_name) }
  let(:flash_create_alert) { I18n.t('flash.actions.create.alert', resource_name) }
  describe '#save_tweet' do
    let(:tweet) { build(:tweet) }
    before do
      allow(controller).to receive(:resource_name).and_return(resource_name)
      sign_in user
      controller.instance_variable_set(:@tweet, tweet)
    end

    context 'when can save' do
      it 'sets notice flash message' do
        allow(controller.current_user.tweets).to receive(:<<).and_return(true)
        controller.__send__(:save_tweet)
        expect(controller).to set_flash[:notice].to(flash_create_notice)
      end
    end

    context 'when can not save' do
      it 'sets alert flash message' do
        allow(controller.current_user.tweets).to receive(:<<).and_return(false)
        controller.__send__(:save_tweet)
        expect(controller).to set_flash[:alert].to(flash_create_alert)
      end
    end
  end

  describe '#tweet_error' do
    let(:first_error) { 'first_error' }
    let(:errors) { ActiveModel::Errors.new(nil) }

    it 'returns first error' do
      sign_in user
      allow(controller.current_user).to receive(:errors).and_return(errors)
      errors.add(:tweet, first_error)
      result = controller.__send__(:tweet_error)
      expect(result).to eq first_error
    end
  end

  describe 'POST #create' do
    let(:requested_params) { { id: 1, tweet: { text: nil, image: nil } } }

    before { sign_in user }

    it 'redirects to action index' do
      post :create, params: requested_params
      expect(response).to redirect_to action: :index
    end
  end
end
