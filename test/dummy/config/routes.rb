Rails.application.routes.draw do
  resources :bicycles
  resources :items
  mount SimpleCart::Engine => "/simple_cart"
end
