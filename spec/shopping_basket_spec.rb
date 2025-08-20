require_relative '../lib/shopping_basket'
require_relative '../lib/product'
describe ShoppingBasket do
  let(:basket) { ShoppingBasket.new }
  let(:product1) { Product.new(quantity: 1, name: 'book', price: 12.49, exempt: true) }
  let(:product2) { Product.new(quantity: 1, name: 'music CD', price: 14.99) }
  describe '#add_product' do
    it 'adds products to the basket' do
      basket.add_product(product1)
      expect(basket.products).to include(product1)
    end
  end
  describe '#total_tax' do
    it 'calculates total tax for all products' do
      basket.add_product(product1)
      basket.add_product(product2)
      expect(basket.total_tax).to eq(1.50)
    end
  end
  describe '#total_price' do
    it 'calculates total price including tax' do
      basket.add_product(product1)
      basket.add_product(product2)
      expect(basket.total_price).to be_within(0.01).of(28.98)
    end
  end
  describe '#clear' do
    it 'removes all products from basket' do
      basket.add_product(product1)
      basket.clear
      expect(basket.products).to be_empty
    end
  end
end
