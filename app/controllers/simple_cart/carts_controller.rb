module SimpleCart
  class CartsController < SimpleCart::ApplicationController
    before_action :cart_data

    def show
    end

    def checkout
      @order = @cart.build_order
      @order.save
      session.delete(:cart)
      redirect_to order_checkout_index_path(@order)
    end

    def add
      @cart.add_item("#{params[:klass]}_#{params[:item_id]}".to_s, params[:qty].to_i)
      redirect_to cart_url
    end

    def update
      @cart.update_items(params)
      render :show
    end

    def destroy
      @cart.remove_item(params[:id])
      render :show
    end

    def remove
      @cart.remove_item(params[:id])
      render :show
    end

    def clear
      session.delete(:cart)
      redirect_to cart_path
    end

    private 

    def cart_data
      @cart = SimpleCart::Cart.new(session[:cart] ||= {})
    end
  end
end

