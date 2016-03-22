module SimpleCart
  module ActsAsSimpleCart
    extend ActiveSupport::Concern

    module ClassMethods
      def acts_as_product
        class_eval do
          has_many :order_items, class_name: 'SimpleCart::OrderItem', as: :itemable
        end
      end
    end
  end
end

ActiveRecord::Base.include(SimpleCart::ActsAsSimpleCart)