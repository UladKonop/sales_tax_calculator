# frozen_string_literal: true

# Manages a collection of products in a shopping basket
class ShoppingBasket
  def initialize
    @products = []
  end

  def add_product(product)
    @products << product
  end

  def products
    @products.dup
  end

  def total_tax
  @products.sum { |product| product.quantity * product.tax_amount }
  end

  def total_price
  @products.sum { |product| product.quantity * product.total_price_with_tax }
  end

  def clear
    @products.clear
  end
end
