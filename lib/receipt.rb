# frozen_string_literal: true

# Formats and displays receipt information
class Receipt
  def initialize(basket)
    @basket = basket
  end

  def generate
    output = []
    
    @basket.products.each do |product|
      total_line_price = product.quantity * product.total_price_with_tax
      formatted_price = format('%.2f', total_line_price)
      output << "#{product.quantity} #{product.display_name}: #{formatted_price}"
    end
    
    output << "Sales Taxes: #{format('%.2f', @basket.total_tax)}"
    output << "Total: #{format('%.2f', @basket.total_price)}"
    
    output.join("\n")
  end

  def print
    puts generate
  end
end
