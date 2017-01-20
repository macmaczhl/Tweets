json.extract! tweet, :id, :text, :image, :created_at, :updated_at
json.url tweet_url(tweet, format: :json)