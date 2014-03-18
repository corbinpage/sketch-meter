class Tweet < ActiveRecord::Base
  belongs_to :scan

  SKETCH_METER_ACCESS_TOKEN = ENV['SKETCH_METER_ACCESS_TOKEN']
  SKETCH_METER_ACCESS_TOKEN_SECRET = ENV['SKETCH_METER_ACCESS_TOKEN_SECRET']

  def self.initialize_twitter_client
    @@client = Twitter::REST::Client.new do |config|
      config.consumer_key     = SKETCH_METER_ACCESS_TOKEN
      config.consumer_secret  = SKETCH_METER_ACCESS_TOKEN_SECRET
    end
  end

end
