module SimpleCart
  class Order < ActiveRecord::Base
    include AASM
    belongs_to :delivery
    
    has_many :order_items, dependent: :destroy
    has_one :credit_card, dependent: :destroy
    has_one :billing_address, dependent: :destroy
    has_one :shipping_address, dependent: :destroy

    accepts_nested_attributes_for :shipping_address
    accepts_nested_attributes_for :billing_address
    accepts_nested_attributes_for :credit_card
    

    validates :total_price, :completed_date, :aasm_state, presence: true
    validates :total_price, numericality: true  

    aasm do
      state :in_progress, :initial => true
      state :in_queue
      state :in_delivery
      state :delivered
      state :canceled

      event :queued do
        transitions :from => :in_progress, :to => :in_queue
      end
    end

    ['billing_address', 'shipping_address', 'credit_card'].each do |method|
      define_method("build_or_find_#{method}") do
        self.instance_eval(method).nil? ? instance_eval("build_#{method}") : instance_eval(method)
      end
    end

    def subtotal
      order_items.inject(0) { |n, order_item| n += order_item.price * order_item.qty }
    end
  end
end