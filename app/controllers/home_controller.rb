class HomeController < ApplicationController
  def index
    if !user_signed_in?
      render template: 'templates/index', layout: 'unauthenticated'
    end
  end
end
