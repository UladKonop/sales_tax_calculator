# frozen_string_literal: true

# Determines if a product is exempt from basic tax
class ExemptionChecker
  EXEMPT_KEYWORDS = %w[book chocolate pills medicine medical food].freeze

  def self.exempt?(product_name)
    normalized_name = product_name.downcase
    EXEMPT_KEYWORDS.any? { |keyword| normalized_name.include?(keyword) }
  end
end
