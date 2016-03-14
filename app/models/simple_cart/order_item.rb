module SimpleCart
  class OrderItem < ActiveRecord::Base
    belongs_to :itemable, polymorphic: true
    belongs_to :order
  end
end