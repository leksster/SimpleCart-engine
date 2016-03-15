FactoryGirl.define do 
  factory :thing do |n|
    n.sequence(:name) { |n| "Thing#{n}" }
    price 52.2
    qty 4
  end
end