Rails.application.routes.draw do
  root "landing_pages#home"

  resources :listings, only: [:index, :show]
  resources :reservations, only: [:create, :index, :show]

  namespace :admin do
    resources :photos, only: [:index, :create, :destroy]
    resources :listings do
      resources :rooms, only: [:index, :create, :destroy]
    end
  end

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
end
