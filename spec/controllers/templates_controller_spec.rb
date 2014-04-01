require 'spec_helper'

describe TemplatesController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'template', {path: 'index'}
      response.should be_success
    end
  end

  describe "GET 'users/confirm'" do
    it "returns http success" do
      get 'template', {path: 'users/confirm'}
      response.should be_success
    end
  end

  describe "GET 'users/profile'" do
    it "returns http success" do
      get 'template', {path: 'users/profile'}
      response.should be_success
    end
  end

  describe "GET 'users/sign_up'" do
    it "returns http success" do
      get 'template', {path: 'users/sign_up'}
      response.should be_success
    end
  end

  describe "GET 'users/forgot_password'" do
    it "returns http success" do
      get 'template', {path: 'users/forgot_password'}
      response.should be_success
    end
  end

  describe "GET 'users/sign_in'" do
    it "returns http success" do
      get 'template', {path: 'users/sign_in'}
      response.should be_success
    end
  end

  describe "GET 'users/unlock'" do
    it "returns http success" do
      get 'template', {path: 'users/unlock'}
      response.should be_success
    end
  end

end
