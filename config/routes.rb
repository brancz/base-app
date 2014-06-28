BaseApp::Application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  devise_for :users, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}

  get '/users/profile/me', to: 'profiles#me'
  #resource :session, only: [:create, :destroy]
  namespace :admin do
    resources :users, except: [:new, :edit]
    resources :roles, except: [:new, :edit]
  end

  root :to => "home#index"
end
