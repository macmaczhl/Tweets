class AddUrlToTweets < ActiveRecord::Migration[5.0]
  def change
    add_column :tweets, :url, :string, null: false
  end
end
