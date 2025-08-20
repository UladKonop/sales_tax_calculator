require_relative '../lib/product_parser'
describe ProductParser do
  describe '.parse' do
    it 'parses valid input correctly' do
      product = ProductParser.parse('2 book at 12.49')
      expect(product.quantity).to eq(2)
      expect(product.name).to eq('book')
      expect(product.price).to eq(12.49)
      expect(product.exempt).to be true
      expect(product.imported).to be false
    end
    it 'identifies imported products' do
      product = ProductParser.parse('1 imported bottle of perfume at 47.50')
      expect(product.imported).to be true
      expect(product.name).to eq('imported bottle of perfume')
    end
    it 'raises error for invalid input format' do
      expect {
        ProductParser.parse('invalid input')
      }.to raise_error(ArgumentError, /Invalid input format/)
    end
  end
end
