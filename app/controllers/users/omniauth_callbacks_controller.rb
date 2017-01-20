# frozen_string_literal: true
module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    FLASH_MESSAGE_KIND = 'Twitter'

    def twitter
      @user = User.from_omniauth(request.env['omniauth.auth'])

      if @user.persisted?
        sign_in @user
        set_flash_message(:notice, :success, kind: FLASH_MESSAGE_KIND)
      else
        set_flash_message(:notice, :failure, kind: FLASH_MESSAGE_KIND, reason: @user.errors.full_messages.first)
      end
      redirect_to root_path
    end

    def failure
      flash[:notice] = 'Sign in error'
      redirect_to root_path
    end
  end
end
