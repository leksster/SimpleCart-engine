require 'faker'
FactoryGirl.define do 
  factory :address, :class => SimpleCart::Address do
    firstname Faker::Name.first_name
    lastname Faker::Name.last_name
    address Faker::Address.street_address
    zipcode Faker::Address.zip_code
    city Faker::Address.city
    phone Faker::PhoneNumber.cell_phone
    country Faker::Number.between(1, 50).to_s

    factory :billing_address, class: 'SimpleCart::BillingAddress' do
    end

    factory :shipping_address, class: 'SimpleCart::ShippingAddress' do
    end
  end
end