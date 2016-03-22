Rails.application.routes.draw do
  mount SimpleCart::Engine, at: "/shop"
  resources :kks
  resources :things
  resources :bicycles
  resources :items
end
