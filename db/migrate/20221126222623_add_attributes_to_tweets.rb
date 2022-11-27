class AddAttributesToTweets < ActiveRecord::Migration[6.1]
  def change
    add_column :tweets, :user, :string
    add_column :tweets, :content, :string
  end
end
