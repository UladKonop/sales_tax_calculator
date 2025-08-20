require_relative '../lib/product'

describe Product do
  describe '#initialize' do
    it 'creates a product with valid attributes' do
      product = Product.new(quantity: 1, name: 'book', price: 12.49)
      expect(product.quantity).to eq(1)
      expect(product.name).to eq('book')
      expect(product.price).to eq(12.49)
      expect(product.imported).to be false
      expect(product.exempt).to be false
    end

    it 'raises error for invalid quantity' do
      expect {
        Product.new(quantity: 0, name: 'book', price: 12.49)
      }.to raise_error(ArgumentError, 'Quantity must be positive')
    end

    it 'raises error for negative price' do
      expect {
        Product.new(quantity: 1, name: 'book', price: -1)
      }.to raise_error(ArgumentError, 'Price must be non-negative')
    end

    it 'raises error for empty name' do
      expect {
        Product.new(quantity: 1, name: '', price: 12.49)
      }.to raise_error(ArgumentError, 'Name cannot be empty')
    end
  end

  describe '#total_price_with_tax' do
    it 'calculates correct price for exempt product' do
      product = Product.new(quantity: 1, name: 'book', price: 12.49, exempt: true)
      expect(product.total_price_with_tax).to be_within(0.01).of(12.49)
    end

    it 'calculates correct price for non-exempt product' do
      product = Product.new(quantity: 1, name: 'music CD', price: 14.99)
      expect(product.total_price_with_tax).to be_within(0.01).of(16.49)
    end

    it 'calculates correct price for imported product' do
      product = Product.new(quantity: 1, name: 'imported perfume', price: 47.50, imported: true)
      expect(product.total_price_with_tax).to be_within(0.01).of(54.65)
    end
  end
end
