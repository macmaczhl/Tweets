# frozen_string_literal: true
module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    FLASH_MESSAGE_KIND = 'Twitter'

    def twitter
      @user = User.from_omniauth(request.env['omniauth.auth'])

      if @user.persisted?
        sign_in @user
        redirect_to tweets_path(@user)
      else
        set_flash_message(:notice, :failure, kind: FLASH_MESSAGE_KIND, reason: @user.errors.full_messages.first)
        redirect_to root_path
      end
    end

    def failure
      redirect_to root_path, notice: 'Sign in error'
    end
  end
end
