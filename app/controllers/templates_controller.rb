class TemplatesController < ApplicationController
  layout false
  helper_method :devise_mapping

  before_filter lambda{ puts "Logged in? -> #{user_signed_in?}" }

  def template
    render template: 'templates/' + params[:path], layout: false
  end

  private

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
