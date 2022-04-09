Rails.application.routes.draw do
  root "landing_pages#home"

  resources :listings, only: [:index, :show]

  namespace :admin do
    resources :listings
  end

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
end
