module SimpleCart

  class Cart

    attr_accessor :session

    def initialize(cart_session)
      @session = cart_session
    end

    def subtotal
      subtotal = 0
      unless @session.nil?
        @session.each do |klass_with_id, qty|
          subtotal += find_in_model(klass_with_id).price * qty
        end
        subtotal -= @discount unless @discount.nil?
        subtotal
      end
    end

    def items
      unless @session.nil?
        arr = []
        @session.each do |klass_with_id, qty|
          arr << find_in_model(klass_with_id)
        end
        arr
      end
    end

    def order_items
      items = []
      self.items.each do |item|
        items << OrderItem.new(price: item.price, qty: @session["#{item.class}_#{item.id}".to_s], itemable: item)
      end
      items
    end

    def build_order
      order = Order.new(total_price: self.subtotal, completed_date: Time.now)
      order.order_items << self.order_items
      order
    end

    def add_item(book_id, qty)
      qty = 1 unless qty > 0
      @session[book_id].nil? ? @session[book_id] = qty : @session[book_id] += qty
    end

    def remove_item(item_id)
      @session.delete(item_id)
    end

    def update_items(params)
      @session.each do |k, v|
        params[k] = 1 unless params[k].to_i > 0
        @session[k] = params[k].to_i
      end
      @discount = discount(params[:coupon]) if using_coupon?
    end

    def using_coupon?
      SimpleCart.coupon_class
    rescue
      false
    end

    def discount(code=nil)
      coupon = SimpleCart.coupon_class.find_by(code: code)
      self.subtotal * (coupon.discount / 100.0) unless coupon.nil?
    end

    private 
    def find_in_model(klass_with_id)
      klass_with_id.split('_')[0].constantize.find(klass_with_id.split('_')[1])
    end
  end
end