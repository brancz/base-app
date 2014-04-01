class TemplatesController < ApplicationController
  layout false
  helper_method :devise_mapping

  def template
    render template: 'templates/' + params[:path], layout: false
  end

  private

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
