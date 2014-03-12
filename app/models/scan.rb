class Scan < ActiveRecord::Base

  SKETCH_METER_ACCESS_TOKEN = ENV['SKETCH_METER_ACCESS_TOKEN']
  SKETCH_METER_ACCESS_TOKEN_SECRET = ENV['SKETCH_METER_ACCESS_TOKEN_SECRET']

  def run
    return unless user_exsts?

    get_users_statuses

    get_users_connections



  end

  def user_exsts?
    begin
      @user = @client.user(self.name)
      self.error = "Success"
      true
    rescue
      self.error = "Does Not Exist"
      false
    end
  end

  def get_users_statuses
    tweets = @client.user_timeline(self.username, count: 200)
    # GET statuses/user_timeline -> can get 200 at a time total
    # GET statuses/retweets_of_me -> most retweets if you want
  end

  def get_users_connections

    # GET friends/list -> Following usernames+descriptions
    # GET followers/list -> Followers
    # GET users/lookup -> hydrated user object
  end

  def initialize_twitter_client
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key     = SKETCH_METER_ACCESS_TOKEN
      config.consumer_secret  = SKETCH_METER_ACCESS_TOKEN_SECRET
    end
  end


end
