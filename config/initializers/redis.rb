if Rails.env.production?
  redis = Redis.new(url: ENV['REDISTOGO_URL'])
else
  redis = Redis.new
end

$redis = Redis::Namespace.new("base_app", redis: redis)
