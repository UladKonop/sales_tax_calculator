# frozen_string_literal: true

# Handles tax calculations with proper rounding
class TaxCalculator
  BASIC_TAX_RATE = 0.10
  IMPORT_TAX_RATE = 0.05
  ROUNDING_PRECISION = 0.05

  def self.calculate_tax(product)
    basic_tax = calculate_basic_tax(product)
    import_tax = calculate_import_tax(product)
    round_up_to_nearest_nickel(basic_tax + import_tax)
  end

  private_class_method def self.calculate_basic_tax(product)
    return 0 if product.exempt
    product.price * BASIC_TAX_RATE
  end

  private_class_method def self.calculate_import_tax(product)
    return 0 unless product.imported
    product.price * IMPORT_TAX_RATE
  end

  private_class_method def self.round_up_to_nearest_nickel(amount)
    return 0.0 if amount <= 0
    (amount / ROUNDING_PRECISION).ceil * ROUNDING_PRECISION
  end
end
