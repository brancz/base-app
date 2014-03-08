BaseApp::Application.routes.draw do
  devise_for :users

  namespace :api, defaults: { format: :json } do
    resource :session, only: [:create, :destroy]
  end

  root 'home#index'

	get '/templates/index' => 'templates#index'
	get '/templates/login' => 'templates#login'
	get '/templates/:path.html' => 'templates#template', :constraints => { :path => /.+/ }
end
