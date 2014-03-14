class AddAverageSentimentToScans < ActiveRecord::Migration
  def change
    add_column :scans, :average_sentiment, :float
  end
end
