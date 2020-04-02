Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :books

  root 'home#top'
  get 'home/top' => 'home#top'
  get 'home/about' => 'home#about'
end
