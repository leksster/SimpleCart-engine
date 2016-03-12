module SimpleCart
  class CartsController < SimpleCart::ApplicationController
    before_action :cart_data, except: :clear

    def show
    end

    def checkout
      @order = @cart.build_order
      @order.save
      redirect_to order_checkout_index_path(@order), alert: "ok"
      # respond_to do |format|
      #   @order = @cart.build_order_for(current_user)
      #   @order.total_price -= @cart.discount(params[:coupon]) unless @cart.discount(params[:coupon]).nil?
      #   if @order.save && !@cart.session.empty?
      #     format.html { redirect_to order_checkout_index_path(@order), notice: 'In order to proceed, please provide additional details.' }
      #     session.delete(:cart)
      #   else
      #     format.html { redirect_to cart_path, alert: "Something went wrong" }
      #   end
      # end
    end

    def add
      @cart.add_item("#{params[:klass]}_#{params[:item_id]}".to_s, params[:qty].to_i)
      redirect_to cart_url
    end

    def update
      @cart.update_books(params)
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
      @cart = Cart.new(session[:cart] ||= {})
    end
  end
end

