SimpleCart::Engine.routes.draw do
  resource :cart, only: [:show, :destroy, :update] do
    post :clear
    get :remove
    post :checkout
    post ':item_id' => 'carts#add', as: :add_to
  end

  resources :orders, only: [:index, :show, :update] do
    resources :checkout, only: [:index, :show, :update]
  end
  
  root to: 'carts#show'
end
