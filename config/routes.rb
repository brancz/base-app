BaseApp::Application.routes.draw do
  devise_scope :user do get '/api/users/me', to: 'registrations#me' end

  devise_for :users, path_prefix: 'api', defaults: {format: :json}, controllers: {registrations: 'registrations'}

  namespace :api, defaults: { format: :json } do
    resource :session, only: [:create, :destroy]
    namespace :admin do
      resources :users, except: [:new, :edit]
      resources :roles, except: [:new, :edit]
    end
  end

  root 'home#index'

	get '/templates/index' => 'templates#index'
	get '/templates/login' => 'templates#login'
	get '/templates/:path.html' => 'templates#template', :constraints => { :path => /.+/ }
end
