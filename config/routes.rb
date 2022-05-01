require 'sidekiq/web'

Rails.application.routes.draw do
  root "landing_pages#home"

  resources :listings, only: [:index, :show]
  resources :reservations, only: [:create, :index, :show]
  post '/webhooks/:source', to: 'webhooks#create'

  namespace :admin do
    resources :photos, only: [:index, :create, :destroy]
    resources :listings do
      resources :rooms, only: [:index, :create, :destroy]
    end
  end

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  # TODO: change to user admin
  authenticate :user, ->(user) { user.id == 3 } do
    mount Sidekiq::Web => '/sidekiq'
  end
end
