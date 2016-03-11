SimpleCart::Engine.routes.draw do
  resource :cart, only: [:show, :destroy, :update] do
    get :clear
    get :remove
    post :checkout
    post ':item_id' => 'carts#add', as: :add_to
  end

  root to: 'carts#show'
end
