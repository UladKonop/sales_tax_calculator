require_relative '../lib/sales_tax_application'
describe SalesTaxApplication do
  let(:app) { SalesTaxApplication.new }
  describe '#process_input' do
    it 'processes valid input successfully' do
      input = ['2 book at 12.49', '1 music CD at 14.99']
      expect(app.process_input(input)).to be true
    end
    it 'handles invalid input gracefully' do
      input = ['invalid input']
      expect { app.process_input(input) }.to output(/Error parsing line/).to_stdout
    end
  end
  describe 'integration test cases' do
    it 'produces correct output for test case 1' do
      input = [
        '2 book at 12.49',
        '1 music CD at 14.99',
        '1 chocolate bar at 0.85'
      ]
      app.process_input(input)
      receipt = app.generate_receipt
      output = receipt.generate
      expect(output).to include('2 book: 24.98')
      expect(output).to include('1 music CD: 16.49')
      expect(output).to include('1 chocolate bar: 0.85')
      expect(output).to include('Sales Taxes: 1.50')
      expect(output).to include('Total: 42.32')
    end
    it 'produces correct output for test case 2' do
      input = [
        '1 imported box of chocolates at 10.00',
        '1 imported bottle of perfume at 47.50'
      ]
      app.process_input(input)
      receipt = app.generate_receipt
      output = receipt.generate
      expect(output).to include('1 imported box of chocolates: 10.50')
      expect(output).to include('1 imported bottle of perfume: 54.65')
      expect(output).to include('Sales Taxes: 7.65')
      expect(output).to include('Total: 65.15')
    end
    it 'produces correct output for test case 3' do
      input = [
        '1 imported bottle of perfume at 27.99',
        '1 bottle of perfume at 18.99',
        '1 packet of headache pills at 9.75',
        '3 imported boxes of chocolates at 11.25'
      ]
      app.process_input(input)
      receipt = app.generate_receipt
      output = receipt.generate
      expect(output).to include('1 imported bottle of perfume: 32.19')
      expect(output).to include('1 bottle of perfume: 20.89')
      expect(output).to include('1 packet of headache pills: 9.75')
      expect(output).to include('3 imported boxes of chocolates: 35.55')
      expect(output).to include('Sales Taxes: 7.90')
      expect(output).to include('Total: 98.38')
    end
  end
end
