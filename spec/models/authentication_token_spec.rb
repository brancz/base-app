require 'spec_helper'

describe AuthenticationToken do
  before do
    $redis.flushdb
  end

  after do
    $redis.flushdb
  end

  it "is valid if the token is created without params" do
    expect(AuthenticationToken.new.valid?).to be true
  end

  it "is valid if a token is created and it is used to create a new instance" do
    token = AuthenticationToken.new.token
    expect(AuthenticationToken.new(token).valid?).to be true
  end

  it "is expired if last seen is passed longer then ttl" do
    token = AuthenticationToken.new
    token.last_seen = (Devise.timeout_in + 1.minute).ago
    expect(token.expired?).to be true
  end

  it "is invalid if is created with a token not in redis" do
    expect(AuthenticationToken.new(MicroToken.generate(128)).valid?).to be false
  end
end
