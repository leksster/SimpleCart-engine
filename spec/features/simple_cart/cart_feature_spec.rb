module SimpleCart
  feature "Cart" do
    let(:thing) { FactoryGirl.create(:thing) }
    
    before :each do
      visit thing_path(thing.id)
    end

    scenario "Visitors can see Add to cart button" do
      expect(page).to have_selector(:link_or_button, 'Add to cart')
    end

    scenario "Visitors can Add one book to cart" do
      find(:button, 'Add to cart').click
      expect(page.current_path).to eq(simple_cart.cart_path)
      expect(page).to have_content(thing.name)
    end

    scenario "Visitors can Add numerous books to cart" do
      fill_in "qty", with: '5'
      find(:button, 'Add to cart').click
      expect(page).to have_field('1', with: '5')
    end

    scenario "Visitors can Empty the cart" do
      find(:button, 'Add to cart').click
      find(:link, 'Empty cart').click
      expect(page).to have_content('empty')
    end

    scenario "Visitors can update quantity of the book in the cart" do
      fill_in "qty", with: '5'
      find(:button, 'Add to cart').click
      fill_in "1", with: '50'
      find(:button, 'Update').click
      expect(page).to have_field('1', with: '50')
    end

    scenario "Visitor can delete specific book from the cart" do
      find(:button, 'Add to cart').click
      visit thing_path(thing)
      find(:button, 'Add to cart').click
      find(:link, 'X', href: "#{current_path}/remove?id=#{thing.class.to_s}_#{thing.id}").click
      expect(page).not_to have_content(thing.name)
    end
  end
end