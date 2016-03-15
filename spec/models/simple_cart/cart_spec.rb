module SimpleCart
  RSpec.describe Cart, type: :model do
    let(:thing1) { FactoryGirl.create(:thing) }
    let(:thing2) { FactoryGirl.create(:thing) }
    let(:cart) { SimpleCart::Cart.new("#{thing1.class.to_s}_#{thing1.id}" => 5, "#{thing2.class.to_s}_#{thing2.id}" => 2) }

    it "correct stubbed models" do
      expect(thing1).to be_a(Thing)
      expect(thing2).to be_a(Thing)
    end

    it '#subtotal' do
      expect(cart.subtotal).to eq(thing1.price * 5 + thing2.price * 2)
    end

    it "#items" do
      expect(cart.items).to eq([thing1, thing2])
    end

    it "#order_items" do
      expect(cart.order_items).to be_a(Array)
      expect(cart.order_items).to include(a_kind_of(OrderItem))
    end

    it "#build_order" do
      expect(cart.build_order).to be_a(Order)
    end

    it '#add_item' do
      expect { cart.add_item(12, 2) }.to change { cart.session }
    end

    it '#remove_item' do 
      expect { cart.remove_item("#{thing1.class.to_s}_#{thing1.id}") }.to change {cart.session}.from({"#{thing1.class.to_s}_#{thing1.id}"=>5, "#{thing2.class.to_s}_#{thing2.id}" =>2}).to({"#{thing2.class.to_s}_#{thing2.id}"=>2})
    end

    it '#update_items' do
      params = {"#{thing1.class.to_s}_#{thing1.id}" => 2, "#{thing2.class.to_s}_#{thing2.id}" => 1}
      expect { cart.update_items(params) }.to change{cart.session}.from({"#{thing1.class.to_s}_#{thing1.id}"=>5, "#{thing2.class.to_s}_#{thing2.id}"=>2}).to({"#{thing1.class.to_s}_#{thing1.id}"=>2, "#{thing2.class.to_s}_#{thing2.id}"=>1})
    end

    # it '#discount' do
    #   coupon = create(:coupon)
    #   expect(cart.discount(coupon.code)).to eq(cart.subtotal*coupon.discount/100.0)
    # end
  end 
end