# frozen_string_literal: true
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable,
         :omniauthable, omniauth_providers: [:twitter]

  has_many :tweets

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email || auth.info.nickname
      user.password = Devise.friendly_token[0, 20]
    end
  end
end
