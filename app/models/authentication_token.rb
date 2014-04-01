class AuthenticationToken
  TTL = Devise.timeout_in

  def initialize(existing_token=nil)
    @token = existing_token

    new = !exists? && @user.nil? && @last_seen.nil? && existing_token.nil?
    if new || valid?
      self.last_seen = Time.now
    end
  end

  def token
    @token ||= MicroToken.generate 128
  end

  def ttl
    return 0 if deleted? || last_seen.nil? # last seen is nil when the token does not exist
    elapsed = Time.now - last_seen
    remaining = TTL - elapsed
    remaining > 0 ? remaining : 0
  end

  def expired?
    ttl <= 0
  end

  def valid?
    !expired?
  end

  def user
    return if expired?
    @user ||= retrieve_user
  end

  def user=(user)
    set_with_expire(user_id_key, user.id)
    @user = user
  end

  def last_seen
    @last_seen ||= retrieve_last_seen
  end

  def last_seen=(seen_at)
    set_with_expire(last_seen_key, seen_at.iso8601)
    @last_seen = seen_at
  end

  def delete!
    redis.del(last_seen_key, user_id_key)
    @deleted = true
  end

  def deleted?
    @deleted
  end

  def exists?
    redis.exists(user_id_key) && redis.exists(last_seen_key)
  end

  private

  def set_with_expire(key, val)
    redis[key] = val
    redis.expire(key, TTL)
  end

  def retrieve_last_seen
    seen_at = redis[last_seen_key]
    seen_at && Time.parse(seen_at)
  end

  def retrieve_user
    user_id = redis[user_id_key]
    User.find_by_id(user_id) if user_id
  end

  def last_seen_key
    "session_token:#{token}:last_seen"
  end

  def user_id_key
    "session_token:#{token}:user_id"
  end

  def redis
    $redis
  end

end
