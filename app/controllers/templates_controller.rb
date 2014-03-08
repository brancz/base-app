class TemplatesController < ApplicationController
	layout false
	helper_method :resource_name, :resource_class, :resource, :devise_mapping

	before_filter :authenticate_user!, except: [:index, :login]

	def index
	end
	
	def login
	end

	def template
		render template: 'templates/' + params[:path], layout: false
	end

	private

	def resource_name
		:user
	end

	def resource_class
		resource.class
	end

	def resource
		@resource ||= User.new
	end

	def devise_mapping
		@devise_mapping ||= Devise.mappings[:user]
	end
end
