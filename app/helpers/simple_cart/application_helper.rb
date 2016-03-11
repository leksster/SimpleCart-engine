module SimpleCart
  module ApplicationHelper
    def add_to_cart(item)
      render(:partial => 'simple_cart/carts/buy', locals: { item: item } )
    end
  end
end