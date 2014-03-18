class Scan < ActiveRecord::Base
  has_many :tweets, :dependent => :destroy


  def run
    return unless user_exsts?

    get_users_statuses

    get_users_connections

  end

  def user_exsts?
    # begin
      @user = @client.user(self.username)
      self.error = "Success"
      true
    # rescue
    #   self.error = "Does Not Exist"
    #   false
    # end
  end

  def get_users_statuses
    full_tweets = Tweet.client.user_timeline(self.username, count: 200)

    # Set Obscenity configs
    Obscenity.configure do |config|
      config.blacklist   = "config/blacklist.yml"
      config.whitelist   = ["Corbin!"]
      config.replacement = :garbled
    end

    total_score = 0
    total_sentiment = 0
    full_tweets.each do |t|
      new_tweet = Tweet.new(text: t.full_text, tweet_time: t.created_at,
                            twitter_id: t.id, scan_id: self.id)

      dirty_words = Obscenity.offensive(t.full_text)
      # sentiment = Sentimentalizer.analyze(t.full_text)

      new_tweet.score = dirty_words.count
      total_score += new_tweet.score
      new_tweet.dirty_words = dirty_words.join(', ')
      new_tweet.sentiment_score = @analyzer.get_score(t.full_text)
      total_sentiment = new_tweet.sentiment_score
      new_tweet.sentiment_summary = @analyzer.get_sentiment(t.full_text)
      new_tweet.save
    end
    self.score = total_score
    self.average_sentiment = total_sentiment / self.tweets.count
    # GET statuses/user_timeline -> can get 200 at a time total
    # GET statuses/retweets_of_me -> most retweets if you want
  end

  def get_users_connections

    # GET friends/list -> Following usernames+descriptions
    # GET followers/list -> Followers
    # GET users/lookup -> hydrated user object
  end

  def initialize_services
    Tweet.initialize_twitter_client
    
    Sentimental.load_defaults
    Sentimental.threshold = 0.1
    @analyzer = Sentimental.new

    @client
  end


end
