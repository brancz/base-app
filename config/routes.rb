BaseApp::Application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  devise_for :users, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}
  get '/users', to: 'profiles#me'

  namespace :api, defaults: { format: :json } do
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
