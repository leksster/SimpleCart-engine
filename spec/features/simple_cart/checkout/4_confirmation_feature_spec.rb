module SimpleCart
  feature 'Checkout Step 2: Delivery' do
    let(:order) do
      FactoryGirl.create(:order, 
             :order_items      => [FactoryGirl.create(:order_item)], 
             :billing_address  => FactoryGirl.create(:billing_address),
             :shipping_address => FactoryGirl.create(:shipping_address),
             :delivery         => FactoryGirl.create(:delivery),
             :credit_card      => FactoryGirl.create(:credit_card))
    end

    background do
      visit simple_cart.order_checkout_path(order, :confirm)
    end

    scenario 'it reaches Step 4 Confirmation' do
      expect(current_path).to include('confirm')
    end

    scenario 'user can go back and forth to any step now' do
      click_link('Address')
      expect(current_path).to include('billing')
      click_link('Delivery')
      expect(current_path).to include('delivery')
      click_link('Payment')
      expect(current_path).to include('payment')
      click_link('Confirm')
      expect(current_path).to include('confirm')
    end

    scenario 'user can procceed to the user\'s order when placed' do
      click_link('Place order')
      expect(current_path).to include("#{order.id}")
    end
  end
end