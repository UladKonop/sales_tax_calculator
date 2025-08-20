# frozen_string_literal: true

require_relative 'shopping_basket'
require_relative 'product_parser'
require_relative 'receipt'

# Main application class that orchestrates the sales tax calculation
class SalesTaxApplication
  def initialize
    @basket = ShoppingBasket.new
  end

  def process_input(input_lines)
    @basket.clear
    
    input_lines.each do |line|
      next if line.strip.empty?
      
      begin
        product = ProductParser.parse(line.strip)
        @basket.add_product(product)
      rescue ArgumentError => e
        puts "Error parsing line '#{line}': #{e.message}"
        return false
      end
    end
    
    true
  end

  def generate_receipt
    Receipt.new(@basket)
  end

  def run_test_cases
    test_cases = [
      [
        "2 book at 12.49",
        "1 music CD at 14.99", 
        "1 chocolate bar at 0.85"
      ],
      [
        "1 imported box of chocolates at 10.00",
        "1 imported bottle of perfume at 47.50"
      ],
      [
        "1 imported bottle of perfume at 27.99",
        "1 bottle of perfume at 18.99",
        "1 packet of headache pills at 9.75",
        "3 imported boxes of chocolates at 11.25"
      ]
    ]

    test_cases.each_with_index do |test_case, index|
      puts "Output #{index + 1}:"
      puts
      
      if process_input(test_case)
        generate_receipt.print
      else
        puts "Failed to process input for test case #{index + 1}"
      end
      
      puts
    end
  end
end
