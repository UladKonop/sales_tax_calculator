require_relative '../lib/receipt'
require_relative '../lib/product_parser'
describe Receipt do
  let(:basket) { ShoppingBasket.new }
  let(:receipt) { Receipt.new(basket) }
  before do
    basket.add_product(ProductParser.parse('2 book at 12.49'))
    basket.add_product(ProductParser.parse('1 music CD at 14.99'))
    basket.add_product(ProductParser.parse('1 chocolate bar at 0.85'))
  end
  describe '#generate' do
    it 'generates correct receipt format' do
      output = receipt.generate
      lines = output.split("\n")
      expect(lines[0]).to eq('2 book: 24.98')
      expect(lines[1]).to eq('1 music CD: 16.49')
      expect(lines[2]).to eq('1 chocolate bar: 0.85')
      expect(lines[3]).to eq('Sales Taxes: 1.50')
      expect(lines[4]).to eq('Total: 42.32')
    end
  end
end
