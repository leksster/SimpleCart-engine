require "simple_cart/engine"

module SimpleCart
  mattr_accessor :coupon_class
  
  def self.coupon_class
    @@coupon_class.constantize
  end
end
