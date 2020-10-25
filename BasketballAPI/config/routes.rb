Rails.application.routes.draw do

  # Resource routes
  resources :users
  resources :games
  resources :players
  resources :favorites
end
