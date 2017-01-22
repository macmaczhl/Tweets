# frozen_string_literal: true
class TweetsController < ApplicationController
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]

  # GET /users/1/tweets
  def index
    redirect_to root_path && return unless user_signed_in?
    @tweet = Tweet.new
    @tweets = Tweet.all.order(created_at: :desc)
  end

  # POST /users/1/tweets
  def create
    @tweet = Tweet.new(tweet_params)
    tweet = current_user.tweet(@tweet.text, params[:tweet][:image])
    if tweet
      @tweet.url = tweet.uri
      save_tweet
    else
      flash[:alert] = I18n.t('flash.actions.create.alert_reason', resource_name.merge(reason: tweet_error))
    end
    redirect_to action: :index
  end

  private

  def save_tweet
    if current_user.tweets << @tweet
      flash[:notice] = I18n.t('flash.actions.create.notice', resource_name)
    else
      flash[:alert] = I18n.t('flash.actions.create.alert', resource_name)
    end
  end

  def tweet_error
    current_user.errors[:tweet].first
  end

  def tweet_params
    params.require(:tweet).permit(:text, :image)
  end

  def resource_name
    { resource_name: I18n.t(:tweer) }
  end
end
