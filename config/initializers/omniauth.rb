# frozen_string_literal: true
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'oWw5D4syoflwCIM6aWHG6RdIH', 'GicUD7lNf6wO10RECZ5IuJROjKtoXZfLL4mp8rCiIL2xgx8VoJ'
end
