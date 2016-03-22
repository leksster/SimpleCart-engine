module SimpleCart
  feature 'Checkout Step 2: Delivery' do
    let(:order) do
      FactoryGirl.create(:order, 
         :order_items      => [FactoryGirl.create(:order_item)], 
         :billing_address  => FactoryGirl.create(:billing_address),
         :shipping_address => FactoryGirl.create(:shipping_address))
    end

    let(:delivery) { FactoryGirl.create(:delivery) }

    background do
      allow(SimpleCart::Delivery).to receive(:first).and_return(delivery)
      visit simple_cart.order_checkout_path(order, :delivery)
    end

    scenario 'it reaches Step 2 Delivery' do
      expect(current_path).to include('delivery')
      expect(page).not_to have_content('Use billing address')
      expect(page).to have_content('Delivery services')
    end

    scenario 'user can return to previous :shipping step' do
      click_link('Back')
      expect(current_path).to include('shipping')
    end

    scenario 'user can return to previous :billing step' do
      click_link('Address')
      expect(current_path).to include('billing')
    end

    scenario 'user can\'t jump to :payment & :confirm steps' do
      click_link('Payment')
      click_link('Confirm')
      expect(current_path).to include('delivery')
    end

    scenario 'user can procceed to the :payment step with valid params' do
      choose "order_delivery_id_#{SimpleCart::Delivery.first.id}"
      click_button('Continue')
      expect(current_path).to include('payment')
    end
  end
end