# frozen_string_literal: true
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable,
         :omniauthable, omniauth_providers: [:twitter]

  has_many :tweets, dependent: :destroy

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email || auth.info.nickname
      user.password = Devise.friendly_token[0, 20]
      user.oauth_token = auth.credentials.token
      user.oauth_secret = auth.credentials.secret
    end
  end

  def tweet(text, image)
    create_client.update_with_media(text, image)
  rescue => exception
    errors.add(:tweet, exception.message)
    nil
  end

  private

  def create_client
    Twitter::REST::Client.new do |config|
      config.consumer_key = Rails.application.config.twitter_key
      config.consumer_secret = Rails.application.config.twitter_secret
      config.access_token = oauth_token
      config.access_token_secret = oauth_secret
    end
  end
end
