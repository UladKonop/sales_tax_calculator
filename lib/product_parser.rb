# frozen_string_literal: true

require_relative 'product'
require_relative 'exemption_checker'

# Parses input strings into Product objects
class ProductParser
  INPUT_PATTERN = /^(\d+)\s+(.+?)\s+at\s+(\d+\.\d{2})$/

  def self.parse(input_line)
    match = input_line.match(INPUT_PATTERN)
    raise ArgumentError, "Invalid input format: #{input_line}" unless match

    quantity = match[1].to_i
    name = match[2].strip
    price = match[3].to_f

    Product.new(
      quantity: quantity,
      name: name,
      price: price,
      imported: imported?(name),
      exempt: ExemptionChecker.exempt?(name)
    )
  end

  private_class_method def self.imported?(name)
    name.downcase.include?('imported')
  end
end
