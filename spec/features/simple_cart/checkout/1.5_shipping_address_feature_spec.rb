module SimpleCart
  feature 'Checkout Step 1.5: Shipping address' do
    let(:order) do
      FactoryGirl.create(:order,
             :order_items     => [FactoryGirl.create(:order_item)], 
             :billing_address => FactoryGirl.create(:billing_address)) 
    end 

    let(:shipping_address) { FactoryGirl.create(:shipping_address) }

    background do
      visit simple_cart.order_checkout_path(order, :shipping)
    end

    scenario 'it reaches Step 1.5 Shipping address.' do
      expect(current_path).to include('shipping')
      expect(page).not_to have_content('Use billing address')
    end

    scenario 'user can return to previous :billing step' do
      click_link('Back')
      expect(current_path).to include('billing')
    end

    scenario 'user can\'t jump to next steps without filled data' do
      click_link('Delivery')
      click_link('Payment')
      click_link('Confirm')
      expect(current_path).to include('billing')
    end

    scenario 'user can procceed to the :delivery step with valid params' do
      fill_in 'order_shipping_address_attributes_firstname', with: shipping_address.firstname
      fill_in 'order_shipping_address_attributes_lastname', with: shipping_address.lastname
      fill_in 'order_shipping_address_attributes_address', with: shipping_address.address
      fill_in 'order_shipping_address_attributes_zipcode', with: shipping_address.zipcode
      fill_in 'order_shipping_address_attributes_city', with: shipping_address.city
      fill_in 'order_shipping_address_attributes_phone', with: shipping_address.phone
      select 'Ukraine', from: 'order[shipping_address_attributes][country]'
      click_button 'Continue'
    end
  end
end