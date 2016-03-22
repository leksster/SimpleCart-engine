module SimpleCart
  RSpec.describe OrdersController, type: :controller do
    let(:order) { 
                  FactoryGirl.create( :order, 
                    order_items: [FactoryGirl.create(:order_item), FactoryGirl.create(:order_item)], 
                    billing_address: FactoryGirl.create(:billing_address), 
                    shipping_address: FactoryGirl.create(:shipping_address), 
                    delivery: FactoryGirl.create(:delivery, :costs => 6), 
                    credit_card: FactoryGirl.create(:credit_card) )
                }

    routes { SimpleCart::Engine.routes }

    before(:each) do 
      allow(SimpleCart::Order).to receive(:find).and_return(order)
    end

    describe "GET #index" do
      let (:action) { :index }
      let (:params) { "" }

      context "visitor" do

        it "returns http success" do
          get action
          expect(response).to have_http_status(:success)
        end

        it "assigns @orders" do
          get action
          expect(assigns(:orders)).to be_a(ActiveRecord::Relation)
        end
        it "assigns @in_progress" do
          get action
          expect(assigns(:in_progress)).to be_a(ActiveRecord::Relation)
        end
        it "assigns @in_queue" do
          get action
          expect(assigns(:in_queue)).to be_a(ActiveRecord::Relation)
        end
        it "assigns @delivered" do
          get action
          expect(assigns(:delivered)).to be_a(ActiveRecord::Relation)
        end
      end
    end

    describe "GET #show" do
      let (:action) { :show }
      let (:params) { {:id => order.id} }

      context "visitor" do
        it "returns http success" do
          get action, :id => order.id
          expect(response).to have_http_status(:success)
        end
        it "assigns @order" do
          get action, :id => order.id
          expect(assigns(:order)).to be(order)
        end
      end
    end

    describe "PUT #update" do
      let (:action) { :update }
      let (:params) { {:id => order.id} }

      context "authenticated user" do
        it "assigns @order" do
          put action, params
          expect(assigns(:order)).to be(order)
        end
        it "changes @order#total_price according to shipments cost" do
          expect{ put action, params }.to change(order, :total_price).by(order.delivery.costs)
        end
        it "changes order#completed_date" do
          expect { put action, params }.to change(order, :completed_date)
        end
        it "saves the order" do
          allow(order).to receive(:queued!).and_return(true)
          expect(order).to receive(:save).and_return(true)
          put action, params
        end
        it "redirects to order path" do
          put action, params
          expect(response).to redirect_to(order_path)
        end
      end
    end
  end
end