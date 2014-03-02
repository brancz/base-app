require 'spec_helper'

describe AuthenticationToken do
  before do
    $redis.flushdb
  end

  after do
    $redis.flushdb
  end

  it "is valid if the token is created without params" do
    AuthenticationToken.new.valid?.should be_true
  end

  it "is valid if a token is created and it is used to create a new instance" do
    token = AuthenticationToken.new.token
    AuthenticationToken.new(token).valid?.should be_true
  end

  it "is expired if last seen is passed longer then ttl" do
    token = AuthenticationToken.new
    token.last_seen = (Devise.timeout_in + 1.minute).ago
    token.expired?.should be_true
  end

  it "is invalid if is created with a token not in redis" do
    AuthenticationToken.new(MicroToken.generate(128)).valid?.should be_false
  end
end
