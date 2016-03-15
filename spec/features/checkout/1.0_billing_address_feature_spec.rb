feature 'Checkout Step 1: Billing address' do
  let(:order) { FactoryGirl.create(:order, :order_items => [FactoryGirl.create(:order_item)]) }
  let(:billing_address) { FactoryGirl.create(:billing_address) }

  background do
    visit simple_cart.order_checkout_index_path(order)
  end

  scenario 'it is on Step 1: Billing Address' do
    expect(current_path).to include('billing')
    expect(page).to have_content('Billing Address')
    expect(page).to have_content('Firstname')
    expect(page).to have_content('Lastname')
    expect(page).to have_content('Address')
    expect(page).to have_content('Zipcode')
    expect(page).to have_content('City')
    expect(page).to have_content('Phone')
    expect(page).to have_content('Country')
    expect(page).to have_content('Use billing address')
  end

  scenario 'user can\'t jump to next steps without filled data' do
    click_link('Delivery')
    click_link('Payment')
    click_link('Confirm')
    expect(current_path).to include('billing')
  end

  feature 'Shipping or Delivery step' do
    background do
      fill_in 'Firstname', with: billing_address.firstname
      fill_in 'Lastname', with: billing_address.lastname
      fill_in 'Address', with: billing_address.zipcode
      fill_in 'Zipcode', with: billing_address.zipcode
      fill_in 'City', with: billing_address.city
      fill_in 'Phone', with: billing_address.phone
      select 'Ukraine', from: 'order[billing_address_attributes][country]'
    end

    scenario 'user can procceed to the :shipping step with unchecked param' do
      uncheck 'shipping_use_billing_address'
      click_button('Save and continue')
      expect(current_path).to include('shipping')
    end

    scenario 'user can procceed to the :delivery step with checked param' do
      check 'shipping_use_billing_address'
      click_button('Save and continue')
      expect(current_path).to include('delivery')
    end
  end
end