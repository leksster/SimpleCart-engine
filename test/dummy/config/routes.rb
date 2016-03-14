Rails.application.routes.draw do
  resources :kks
  resources :things
  resources :bicycles
  resources :items
  mount SimpleCart::Engine => "/simple_cart"
end
