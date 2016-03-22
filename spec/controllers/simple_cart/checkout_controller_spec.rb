require 'byebug'
module SimpleCart
  RSpec.describe CheckoutController, type: :controller do
    let(:order) do
      FactoryGirl.create( :order, 
      order_items: [FactoryGirl.create(:order_item)], 
      billing_address: billing_address, 
      shipping_address: shipping_address, 
      delivery: FactoryGirl.create(:delivery), 
      credit_card: FactoryGirl.create(:credit_card) ) 
    end
    
    let(:shipping_address) { FactoryGirl.create(:shipping_address) }
    let(:billing_address) { FactoryGirl.create(:billing_address) }
    let(:credit_card) { FactoryGirl.create(:credit_card) }
    let(:order_in_queue) { FactoryGirl.create(:order, :aasm_state => 'in_queue') }
    let(:steps) { [:billing, :shipping, :delivery, :payment, :confirm] }

    routes { SimpleCart::Engine.routes }

    describe "GET #show" do

      before(:each) do 
        allow(SimpleCart::Order).to receive(:find).and_return(order)
      end

      shared_examples "receives build_or_find methods" do
        it "#build_or_find_billing_address" do
          expect(order).to receive(:build_or_find_billing_address)
          get(:show, step_params)
        end

        it "#build_or_find_shipping_address" do
          expect(order).to receive(:build_or_find_shipping_address)
          get(:show, step_params)
        end

        it "#build_or_find_credit_card" do
          expect(order).to receive(:build_or_find_credit_card)
          get(:show, step_params)
        end

        it "assignes @order" do
          get :show, step_params
          expect(assigns(:order)).to be_a(SimpleCart::Order)
        end
      end

      context "Steps" do
        
        it_behaves_like "receives build_or_find methods" do
          [:billing, :shipping, :delivery, :payment, :confirm].each do |step|
            let(:step_params) {{ :order_id => order.id, :id => step }}
          end
        end

        context "http success" do
          it "returns http success on every step" do
            steps.each do |step|
              get :show, { :order_id => order.id, :id => step }
              expect(response).to have_http_status(:success)
            end
          end
        end

        context "render the page" do
          it "renders specific view for the current step" do
            steps.each do |step|
              get :show, { :order_id => order.id, :id => step }
              expect(response).to render_template step
            end
          end
        end

        context "redirects" do
          it "redirects to previous step if current is not valid" do
            steps = [:delivery, :payment, :confirm]
            steps.each_with_index do |step, index|
              order = FactoryGirl.create(:order)
              allow(Order).to receive(:find).and_return(order)
              get :show, { :order_id => order.id, :id => step }
              expect(response).to redirect_to order_checkout_path(:order_id => order.id, :id => [:billing, :delivery, :payment][index])
            end
          end
        end
      end
    end

    describe "PUT #update" do

      before(:each) do 
        allow(SimpleCart::Order).to receive(:find).and_return(order)
        allow(order).to receive(:update).and_return(true)
        allow(order).to receive(:build_shipping_address).and_return(shipping_address)
        allow(order).to receive(:billing_address).and_return(billing_address)
      end

      context ":billing step" do
        let(:step_params) do 
          {
            :order_id => order.id, 
            :id       => :billing, 
            :order    => { :billing_address_attributes => FactoryGirl.attributes_for(:billing_address) },
            :shipping  => checked 
          } 
        end

        before do
          allow(order).to receive(:update).and_return(true)
          put :update, step_params
        end

        after { put :update, step_params }
                            
        context "without billing address checkbox checked" do
          let(:checked) { nil }

          it "#update order" do
            expect(order).to receive(:update).with(step_params[:order].with_indifferent_access)
          end

          it "redirects to :shipping" do
            expect(response).to redirect_to order_checkout_path(:order_id => order.id, :id => :shipping)
          end
        end

        context "with billing address checkbox checked" do
          let(:checked) { true }

          it "#update order" do
            expect(order).to receive(:update).with(step_params[:order])
          end

          it "#build_shipping_address" do
            expect(order).to receive(:build_shipping_address)
            
          end

          it "redirects to :delivery" do
            expect(response).to redirect_to order_checkout_path(:order_id => order.id, :id => :delivery)
          end
        end
      end

      context ":shipping step" do
        let(:step_params) do
          { 
            :order_id => order.id, :id => :shipping, 
            :order => { :shipping_address_attributes => FactoryGirl.attributes_for(:shipping_address) } 
          } 
        end

        before { put :update, step_params }

        it "#update order" do
          expect(order).to receive(:update).with(step_params[:order].with_indifferent_access)
          put :update, step_params
        end

        it "redirects to :delivery" do
          expect(response).to redirect_to order_checkout_path(:order_id => order.id, :id => :delivery)
        end    
      end

      context ":delivery step" do
        let(:step_params) do
          {
            :order_id => order.id, 
            :id       => :delivery, 
            :order    => { :delivery_id => FactoryGirl.create(:delivery).id }
          } 
        end 

        before { put :update, step_params }

        it "sets delivery for order" do
          expect(order.delivery).not_to be_nil
        end

        it "redirects to :payment" do
          expect(response).to redirect_to order_checkout_path(:order_id => order.id, :id => :payment)
        end
      end

      context ":payment step" do
        let(:step_params) do
          {
            :order_id => order.id, 
            :id       => :payment, 
            :order    => { :credit_card_attributes => FactoryGirl.attributes_for(:credit_card) }
          } 
        end

        it "#update order" do
          expect(order).to receive(:update).with(step_params[:order].with_indifferent_access)
          put :update, step_params
        end

        it "redirects to :confirm" do
          put :update, step_params
          expect(response).to redirect_to order_checkout_path(:order_id => order.id, :id => :confirm)
        end
      end
    end
  end
end