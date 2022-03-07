Rails.application.routes.draw do
  namespace :admin do
    resources :listings
  end
  root "landing_pages#home"

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
end
