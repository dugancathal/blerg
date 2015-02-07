Rails.application.routes.draw do
  resources :comments

  devise_for :users
  root 'home#index'
  resources :posts
end
