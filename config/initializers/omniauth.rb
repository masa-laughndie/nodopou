Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.production?
    provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
  else
    provider :twitter, ENV['TWITTER_KEY_DEV'], ENV['TWITTER_SECRET_DEV']
  end
end