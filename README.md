# Sales Tax Calculator

A Ruby application that calculates sales tax for shopping baskets according to specific business rules.

## Overview

This application calculates sales tax for products with the following rules:
- **Basic sales tax**: 10% on all goods, except books, food, and medical products
- **Import duty**: Additional 5% on all imported goods with no exemptions
- **Tax rounding**: Rounded up to the nearest 0.05

## Project Structure

```
├── app.rb                       # Main executable file
├── README.md                    # This file
├── lib/                         # Library directory
│   ├── product.rb               # Product class
│   ├── tax_calculator.rb        # Tax calculation logic
│   ├── exemption_checker.rb     # Tax exemption rules
│   ├── product_parser.rb        # Input parsing
│   ├── shopping_basket.rb       # Product collection management
│   ├── receipt.rb               # Receipt formatting
│   └── sales_tax_application.rb # Main application orchestration
└── spec/                        # RSpec test suite (one file per class)
  ├── product_spec.rb
  ├── tax_calculator_spec.rb
  ├── exemption_checker_spec.rb
  ├── product_parser_spec.rb
  ├── shopping_basket_spec.rb
  ├── receipt_spec.rb
  └── sales_tax_application_spec.rb
```

## Requirements

- Ruby 3.0+ (tested with Ruby 3.0.0)
- RSpec (for running tests)

## Installation

1. Ensure you have Ruby installed:
   ```bash
   ruby --version
   ```

2. Install RSpec (optional, for running tests):
   ```bash
   gem install rspec
   ```

## Usage

### Running the Application

The application includes three test cases that demonstrate the functionality:

```bash
ruby app.rb
```

This will output the receipts for all three test cases.

### Expected Output

```
Output 1:

2 book: 24.98
1 music CD: 16.49
1 chocolate bar: 0.85
Sales Taxes: 1.50
Total: 42.32

Output 2:

1 imported box of chocolates: 10.50
1 imported bottle of perfume: 54.65
Sales Taxes: 7.65
Total: 65.15

Output 3:

1 imported bottle of perfume: 32.19
1 bottle of perfume: 20.89
1 packet of headache pills: 9.75
3 imported boxes of chocolates: 35.55
Sales Taxes: 7.90
Total: 98.38
```

### Using the Application Programmatically

```ruby
require_relative 'lib/sales_tax_application'

# Create application instance
app = SalesTaxApplication.new

# Process input
input_lines = [
  "2 book at 12.49",
  "1 music CD at 14.99",
  "1 chocolate bar at 0.85"
]

if app.process_input(input_lines)
  receipt = app.generate_receipt
  receipt.print
end
```

## Testing

Run the test suite with RSpec (all tests):

```bash
rspec spec/
```

Or run a specific test file, for example:

```bash
rspec spec/receipt_spec.rb
```

### Classes

#### `Product`
- **Responsibility**: Represents individual products with attributes
- **Attributes**: quantity, name, price, imported status, exempt status
- **Methods**: `total_price_with_tax`, `tax_amount`, validation

#### `TaxCalculator`
- **Responsibility**: Calculates tax amounts with proper rounding
- **Features**: Stateless class methods, no object instantiation needed
- **Methods**: `calculate_tax` (class method), private calculation methods

#### `ExemptionChecker`
- **Responsibility**: Determines if products are exempt from basic tax
- **Features**: Keyword-based matching for books, food, medical products
- **Methods**: `exempt?` (class method)

#### `ProductParser`
- **Responsibility**: Parses input strings into Product objects
- **Features**: Regex-based parsing, automatic import detection
- **Methods**: `parse` (class method)

#### `ShoppingBasket`
- **Responsibility**: Manages collections of products
- **Features**: Simple array-based storage, calculation aggregation
- **Methods**: `add_product`, `total_tax`, `total_price`, `clear`

#### `Receipt`
- **Responsibility**: Formats and displays receipt information
- **Features**: Proper number formatting, structured output
- **Methods**: `generate`, `print`

#### `SalesTaxApplication`
- **Responsibility**: Main application orchestration
- **Features**: Input processing, error handling, test case execution
- **Methods**: `process_input`, `generate_receipt`, `run_test_cases`

## Assumptions

1. **Input Format**: Fixed format "quantity item_name at price"
2. **Exempt Products**: Keywords include "book", "chocolate", "pills", "medicine", "medical", "food"
3. **Import Detection**: Products containing "imported" in name are considered imported
4. **Price Precision**: Prices given to 2 decimal places
5. **Currency**: All calculations assume same currency (no conversion)

## Error Handling

- Invalid input formats are caught and reported
- Negative quantities and prices are rejected
- Empty product names are rejected
- Application continues processing other valid inputs after errors
