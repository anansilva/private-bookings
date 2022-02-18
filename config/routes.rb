Rails.application.routes.draw do
  root "landing_pages#home"

  devise_for :users

end
