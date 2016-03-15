module SimpleCart
  RSpec.describe Delivery, type: :model do
    subject(:shipping) { Delivery.new(:company => 'Nova poshta', :costs => 42) }
    it 'should be a Delivery class' do
      expect(Delivery.is_a?(Class)).to be_truthy
      expect(Delivery < ActiveRecord::Base).to be_truthy
    end

    it { should have_db_column(:company).of_type(:string) }
    it { should have_db_column(:costs).of_type(:decimal) }

    it { should validate_presence_of(:company) }
  end
end