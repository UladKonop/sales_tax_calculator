#!/usr/bin/env ruby

# frozen_string_literal: true

require_relative 'lib/sales_tax_application'

# Run the application if this file is executed directly
if __FILE__ == $PROGRAM_NAME
  app = SalesTaxApplication.new
  app.run_test_cases
end