class TemplatesController < ApplicationController
  layout false
  helper_method :resource_name, :resource_class, :resource, :devise_mapping

  before_filter :authenticate_user!, except: [:index, :login]

  before_filter lambda{ puts "Logged in? -> #{user_signed_in?}" }

  def index
  end
  
  def login
    @resource_name = :user
    @resource = User.new
    @resource_class = @resource.class
  end

  def template
    render template: 'templates/' + params[:path], layout: false
  end

  private

  def resource_name
    @resource_name
  end

  def resource_class
    @resource_class
  end

  def resource
    @resource
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
