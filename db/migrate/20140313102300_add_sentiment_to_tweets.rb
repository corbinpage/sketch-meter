class AddSentimentToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :sentiment_score, :float
    add_column :tweets, :sentiment_summary, :string
  end
end