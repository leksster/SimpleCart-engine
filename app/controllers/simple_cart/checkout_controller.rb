module SimpleCart
  class CheckoutController < SimpleCart::ApplicationController

    include Wicked::Wizard
    before_action :set_order

    steps :billing, :shipping, :delivery, :payment, :confirm

    def show
      case step
      when :delivery
        jump_to(:billing) if @order.shipping_address.nil?
      when :payment
        jump_to(:delivery) if @order.delivery.nil?
      when :confirm
        jump_to(:payment) if @order.credit_card.nil?
      end
      @order.build_or_find_billing_address
      @order.build_or_find_shipping_address
      @order.build_or_find_credit_card
      render_wizard 
    end

    def update
      case step
      when :billing
        if @order.update(order_params) && !params[:shipping].nil?
          @order.build_shipping_address.attributes = @order.billing_address.attributes.except("id", "type", "user_id")
          jump_to(:delivery)
        end
      when :shipping
        @order.update(order_params)
      when :delivery
        @order.delivery = SimpleCart::Delivery.find(params[:order][:delivery_id])
      when :payment
        @order.update(order_params)
      end
      render_wizard @order
    end

    private

    def set_order
      @order = SimpleCart::Order.find(params[:order_id])
    end

    def order_params
      params.require(:order).permit(:billing_address_attributes  => [:firstname, :lastname, :address, :zipcode, :city, :phone, :country],
                                    :shipping_address_attributes => [:firstname, :lastname, :address, :zipcode, :city, :phone, :country],
                                    :credit_card_attributes      => [:number, :expiration_month, :expiration_year, :cvv, :firstname, :lastname],
                                    :order                       => [:delivery_id])
    end
  end
end