class Tweet < ActiveRecord::Base
  belongs_to :scan

  @@client

  SKETCH_METER_CONSUMER_KEY = ENV['SKETCH_METER_CONSUMER_KEY']
  SKETCH_METER_CONSUMER_SECRET = ENV['SKETCH_METER_CONSUMER_SECRET']

  def self.initialize_twitter_client
    @@client = Twitter::REST::Client.new do |config|
      config.consumer_key     = SKETCH_METER_CONSUMER_KEY
      config.consumer_secret  = SKETCH_METER_CONSUMER_SECRET
    end
  end

  def self.client
    @@client
  end

end
