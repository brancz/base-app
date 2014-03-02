BaseApp::Application.routes.draw do
  devise_for :users
  get "home/index"
  root 'home#index'

  namespace :api, defaults: { format: :json } do
    resource :session, only: [:create, :destroy]
  end
end
