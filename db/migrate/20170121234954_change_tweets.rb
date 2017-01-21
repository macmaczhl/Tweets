class ChangeTweets < ActiveRecord::Migration[5.0]
  def change
    change_column_null :tweets, :user_id, false
  end
end
