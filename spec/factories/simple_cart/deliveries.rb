FactoryGirl.define do 
  factory :delivery, :class => SimpleCart::Delivery do
    company "Fake"
    costs 25.5
  end
end