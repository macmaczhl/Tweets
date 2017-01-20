# frozen_string_literal: true
class TweetsController < ApplicationController
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]

  # GET /users/1/tweets
  def index
    redirect_to root_path && return unless user_signed_in?
    @tweets = Tweet.all
  end

  # POST /users/1/tweets
  def create
    @tweet = Tweet.new(tweet_params)
  end

  private

  def tweet_params
    params.require(:tweet).permit(:text, :image)
  end
end
