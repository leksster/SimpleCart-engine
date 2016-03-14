module SimpleCart
  class OrdersController < SimpleCart::ApplicationController
    before_action :set_order, only: [:show, :edit, :update, :completed]
    
    def index
      @orders = Order.all.order(id: :desc)
      @in_progress = Order.all.where(aasm_state: 'in_progress').order(id: :desc)
      @in_queue = Order.all.where(aasm_state: 'in_queue').order(id: :desc)
      @delivered = Order.all.where(aasm_state: 'delivered').order(id: :desc)
    end

    def show
    end

    def update
      if @order.queued!
        @order.total_price += @order.delivery.costs
        @order.completed_date = Time.now
        @order.save
        redirect_to order_path, notice: "Your order is completed."
      else 
        redirect_to order_checkout_path, alert: "Order state is invalid."
      end
    end

    private
    def set_order
      @order = Order.find(params[:id])
    end
  end
end