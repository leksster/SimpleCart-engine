module SimpleCart
  class Delivery < ActiveRecord::Base
    has_many :orders
    validates :company, presence: true
  end
end