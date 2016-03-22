module SimpleCart
  RSpec.describe CartsController, type: :controller do
    let(:cart) { Cart.new(:session) }
    let(:thing) { FactoryGirl.create(:thing) }
    let(:order) { FactoryGirl.create(:order) }

    routes { SimpleCart::Engine.routes }

    before do 
      allow(controller).to receive(:params).and_return(:klass => thing.class.to_s, :qty => '5', :item_id => thing.id) 
    end

    describe "GET #show" do
      before { get :show }

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
      it "assignes @cart" do
        expect(assigns(:cart)).not_to be_nil
      end    
    end

    describe "POST #add" do
      before do
        allow(Cart).to receive(:new).and_return(cart)
        allow(cart).to receive(:add_item).and_return(true)
        post :add, :item_id => thing.id
      end    
      it "assignes @cart" do
        expect(cart).not_to be_nil
      end
      it "should redirect_to cart when item was added" do
        expect(response).to redirect_to(cart_path)
      end
      it "calls #add_item on @cart" do    
        expect(cart).to receive(:add_item).with("#{thing.class.to_s}_#{thing.id}", controller.params[:qty].to_i)
        post :add, :item_id => thing.id
      end
    end

    describe "POST #update" do
      before do
        allow(Cart).to receive(:new).and_return(cart)
        allow(cart).to receive(:update_items).and_return(order)
        patch :update
      end   
      it "assignes @cart" do
        expect(assigns(:cart)).not_to be_nil
      end
      it "calls #update_books on @cart" do    
        expect(cart).to receive(:update_items)
        patch :update
      end
      it "renders :show" do
        expect(response).to render_template :show
      end
    end

    describe "DELETE #destroy" do
      before do
        allow(Cart).to receive(:new).and_return(cart)
        allow(cart).to receive(:remove_item).and_return(true)
        delete :destroy
      end   
      it "assignes @cart" do
        expect(assigns(:cart)).not_to be_nil
      end
      it "calls #remove_book on @cart" do    
        expect(cart).to receive(:remove_item)
        delete :destroy
      end
      it "renders :show" do
        expect(response).to render_template :show
      end
    end

    describe "POST #clear" do
      it "calls #delete(:cart) on session" do    
        expect(controller.session).to receive(:delete).with(:cart)
        post :clear
      end
      it "redirects to main page" do
        post :clear
        expect(response).to redirect_to(cart_path)
      end
    end

    describe "POST #checkout" do
      before do
        allow(Cart).to receive(:new).and_return(cart)
        allow(cart).to receive(:build_order).and_return(order)
        post :checkout
      end

      it "assignes @cart" do
        expect(assigns(:cart)).not_to be_nil
      end

      it "calls #build_order on cart" do
        expect(cart).to receive(:build_order)
        post :checkout
      end

      it "calls #save on order" do
        expect(order).to receive(:save)
        post :checkout
      end

      it "clears the cart session" do
        expect(controller.session).to receive(:delete).with(:cart)
        post :checkout
      end

      it 'redirects to checkout controller' do
        expect(response).to redirect_to(order_checkout_index_path(order))
      end

      it "assignes @order" do
        expect(assigns(:order)).not_to be_nil
      end
    end
  end
end