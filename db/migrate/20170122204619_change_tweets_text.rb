class ChangeTweetsText < ActiveRecord::Migration[5.0]
  def change
    change_table :tweets do |t|
      t.change :text, :text
    end
  end
end
