require 'rails/generators'

module SimpleCart
  class ViewsGenerator < Rails::Generators::Base
    source_root File.expand_path("../../../../app/views/simple_cart", __FILE__)    
    def copy_views
      directory 'carts', 'app/views/simple_cart/carts'
      directory 'checkout', 'app/views/simple_cart/checkout'
      directory 'orders', 'app/views/simple_cart/orders'
    end
  end
end