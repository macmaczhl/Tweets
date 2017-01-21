# frozen_string_literal: true
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, Rails.application.config.twitter_key, Rails.application.config.twitter_secret,
    {
      authorize_params: {
        force_login: 'true'
      }
    }
end
