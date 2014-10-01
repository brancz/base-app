require 'spec_helper'

describe TemplatesController do
  describe "GET 'index'" do
    it "returns http success" do
      get 'template', {path: 'index'}
      response.should be_success
    end
  end
end
