require "simple_cart/engine"
require "simple_cart/acts_as_simple_cart"

module SimpleCart
  mattr_accessor :coupon_class

  def self.coupon_class
    @@coupon_class.constantize
  end
end
