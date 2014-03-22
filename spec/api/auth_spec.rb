require 'spec_helper'

describe 'API auth' do
  include JsonApiHelpers

  before do
    @user = create(:user)
    $redis.flushdb
  end

  after do
    $redis.flushdb
  end

  describe "POST /api/session" do
    it "should return auth_token for valid email and password" do
      authenticate_successfully
      response.status.should == 201

      json_response['user_token'].should_not be_blank

      auth_token = json_response['user_token']

      $redis.exists(user_id_key(auth_token)).should be_true
      $redis.exists(last_seen_key(auth_token)).should be_true
    end

    it "should return invalid email or password for invalid email or password" do
      post '/api/session', {user_email: "test@example.com", user_password: "badpassword"}
      json_response['error'].should == I18n.t("devise.failure.invalid")
    end

    it "should return invalid email or password when providing empty email and password" do
      post '/api/session', {user_email:'', user_password:''}
      json_response['error'].should == I18n.t("devise.failure.invalid")
    end

    it "should return unauthenticated when providing no email and password" do
      post '/api/session', {}
      json_response['error'].should == I18n.t("devise.failure.unauthenticated")
    end
  end

  describe "DELETE /api/session" do
    it "should return nothing but success when deleting an existing token" do
      authenticate_successfully
      auth_token = json_response['user_token']
      delete '/api/session', nil, {'HTTP_AUTHORIZATION' => auth_token}
      response.status.should == 204
      $redis.exists(user_id_key(auth_token)).should be_false
      $redis.exists(last_seen_key(auth_token)).should be_false
    end

    it "should return untauthenticated when deleting a session with a non existent token" do
      auth_token = MicroToken.generate(128)
      delete '/api/session', nil, {'HTTP_AUTHORIZATION' => auth_token}
      response.status.should == 401
      $redis.exists(user_id_key(auth_token)).should be_false
      $redis.exists(last_seen_key(auth_token)).should be_false
    end
  end

  private

  def authenticate_successfully
    post '/api/session', {user_email: @user.email, user_password: "secretpassword"}
  end

  def user_id_key(token)
    "session_token:#{token}:user_id"
  end

  def last_seen_key(token)
    "session_token:#{token}:last_seen"
  end
end
