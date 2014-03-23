BaseApp::Application.routes.draw do
  devise_scope :user do get '/api/users/myself', to: 'registrations#myself' end

  devise_for :users, path_prefix: 'api', defaults: {format: :json}, controllers: {registrations: 'registrations'}

  namespace :api, defaults: { format: :json } do
    resource :session, only: [:create, :destroy] do
      collection do
        get 'heartbeat'
      end
    end
    namespace :admin do
      resource :users, except: [:create, :new, :edit]
    end
  end

  root 'home#index'

	get '/templates/index' => 'templates#index'
	get '/templates/login' => 'templates#login'
	get '/templates/:path.html' => 'templates#template', :constraints => { :path => /.+/ }
end
