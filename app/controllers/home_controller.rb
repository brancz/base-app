class HomeController < ApplicationController
  def index
    if !user_signed_in?
      render template: 'templates/home', layout: 'unauthenticated'
    end
    if user_signed_in?
      render html: '<div class="body" ui-view=""></div>'.html_safe, layout: 'authenticated'
    end
  end
end
