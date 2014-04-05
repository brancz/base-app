BaseApp::Application.routes.draw do
  devise_for :users, path_prefix: 'api', defaults: {format: :json}, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}

  namespace :api, defaults: { format: :json } do
    get '/users/profile/me', to: 'profiles#me'
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
