# frozen_string_literal: true
class TweetsController < ApplicationController
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]

  # GET /users/1/tweets
  def index
    redirect_to root_path && return unless user_signed_in?
    @tweet = Tweet.new
    @tweets = Tweet.all
  end

  # POST /users/1/tweets
  def create
    @tweet = Tweet.new(tweet_params)
    begin
      current_user.tweet(@tweet.text)
      flash[:notice] = I18n.t('flash.actions.create.notice', resource_name)
    rescue => exception
      flash[:alert] = I18n.t('flash.actions.create.alert', resource_name.merge(reason: exception.message))
    end
    redirect_to action: :index
  end

  private

  def tweet_params
    params.require(:tweet).permit(:text, :image)
  end

  def resource_name
    { resource_name: I18n.t(:tweer) }
  end
end
