FactoryGirl.define do 
  factory :order_item, :class => SimpleCart::OrderItem do |n|
    n.sequence(:price) { |n| n }
    n.sequence(:qty) { |n| n }
    association :itemable, factory: :thing
  end
end