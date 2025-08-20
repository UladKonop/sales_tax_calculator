# frozen_string_literal: true

require_relative 'tax_calculator'

# Represents a product with its attributes and tax calculations
class Product
  attr_reader :quantity, :name, :price, :imported, :exempt

  def initialize(quantity:, name:, price:, imported: false, exempt: false)
    @quantity = quantity
    @name = name
    @price = price
    @imported = imported
    @exempt = exempt
    validate_attributes
  end

  def total_price_with_tax
    price + tax_amount
  end

  def tax_amount
    @tax_amount ||= TaxCalculator.calculate_tax(self)
  end

  def display_name
    name
  end

  private

  def validate_attributes
    raise ArgumentError, 'Quantity must be positive' unless quantity.positive?
    raise ArgumentError, 'Price must be non-negative' unless price >= 0
    raise ArgumentError, 'Name cannot be empty' if name.nil? || name.strip.empty?
  end
end
