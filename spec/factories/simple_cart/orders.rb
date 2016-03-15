require 'faker'
FactoryGirl.define do 
  factory :order, :class => SimpleCart::Order do
    total_price Faker::Number.decimal(2)
    completed_date Faker::Time.between(DateTime.now - 2, DateTime.now - 1)
    aasm_state 'in_progress'
  end
end