class HomeController < ApplicationController
	skip_before_filter :token_authenticate_user!
	skip_before_filter :authenticate_user!

  def index
  end

	def login
	end
end
