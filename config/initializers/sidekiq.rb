if Rails.env.production?
  url = "redis://#{ENV['REDIS_URL']}:80/12"
else
  url = "redis://#{ENV['REDIS_PORT_6379_TCP_ADDR']}:6379/12"
end

Sidekiq.configure_server do |config|
  config.redis = { url: url }
end

Sidekiq.configure_client do |config|
  config.redis = { url: url }
end
