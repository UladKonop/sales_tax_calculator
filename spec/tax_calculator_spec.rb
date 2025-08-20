require_relative '../lib/product'
require_relative '../lib/tax_calculator'

describe TaxCalculator do
  describe '.calculate_tax' do
    it 'calculates no tax for exempt products' do
      product = Product.new(quantity: 1, name: 'book', price: 12.49, exempt: true)
      expect(TaxCalculator.calculate_tax(product)).to eq(0)
    end

    it 'calculates basic tax for non-exempt products' do
      product = Product.new(quantity: 1, name: 'music CD', price: 14.99)
      expect(TaxCalculator.calculate_tax(product)).to eq(1.50)
    end

    it 'calculates import tax for imported products' do
      product = Product.new(quantity: 1, name: 'imported chocolate', price: 10.00, imported: true, exempt: true)
      expect(TaxCalculator.calculate_tax(product)).to eq(0.50)
    end

    it 'calculates both taxes for imported non-exempt products' do
      product = Product.new(quantity: 1, name: 'imported perfume', price: 47.50, imported: true)
      expect(TaxCalculator.calculate_tax(product)).to eq(7.15)
    end

    it 'rounds up to nearest 0.05' do
      product = Product.new(quantity: 1, name: 'item', price: 18.99)
      expect(TaxCalculator.calculate_tax(product)).to be_within(0.01).of(1.90)
    end
  end
end
