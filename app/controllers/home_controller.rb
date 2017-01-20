# frozen_string_literal: true
class HomeController < ApplicationController
  def index
    redirect_to tweets_path(@current_user) if user_signed_in?
  end
end
