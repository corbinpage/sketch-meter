class TwitterDetail < ActiveRecord::Base
  belongs_to :user
  # validates :twitter_uid, uniqueness: true

  def create_or_update_from_omniauth(omniauth)
    self.twitter_uid = omniauth.uid
    self.oauth_token = omniauth.credentials.token
    self.oauth_token_secret = omniauth.credentials.secret
    if omniauth.info
      self.description = omniauth.info.description
      self.profile_image_url = omniauth.info.image
      self.location = omniauth.info.location
      self.name = omniauth.info.name
      self.user_name = omniauth.info.nickname
      self.website_url = omniauth.info.urls.Website
      self.twitter_url = omniauth.info.urls.Twitter
    end
    if omniauth.extra && omniauth.extra.raw_info
      self.account_created_at = omniauth.extra.raw_info.created_at
      self.favorites_count = omniauth.extra.raw_info.favourites_count
      self.followers_count = omniauth.extra.raw_info.followers_count
      self.following_count = omniauth.extra.raw_info.friends_count
      self.total_tweets = omniauth.extra.raw_info.statuses_count
      self.background_image_url = omniauth.extra.raw_info.profile_background_image_url
    end
  end

end
