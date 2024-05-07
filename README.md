# Product CSV Upload API

This Rails API provides functionality to upload product data via CSV files.

Each CSV file should contain product information with the following columns:

````
name, description, price, primary_category, second_category, model_number, upc, and sku.
````


### Getting Started
#### Prerequisites
- Ruby
- Rails
- PostgreSQL (or change the database configuration as needed)

#### Installation

Clone the repository
```
git clone https://github.com/alejandrotoledoweb/rails_csv_api.git
cd rails_csv_api
````

Bundle Install

Install the required Ruby gems including Rails:
```
bundle install
```

Setup Database

This guide assumes PostgreSQL is being used:
```
rails db:create
rails db:migrate
````

Start the Rails ServerStart the Rails server to make the API accessible:
```
rails server
````

The API will be available at http://localhost:3000.

### API Endpoint
#### Upload Products
```
Endpoint: POST /products
Purpose: Uploads a CSV file containing product data.
Content-Type: multipart/form-data
CSV Format
````

Each row in the CSV file should match the following format:

CSV FORMAT
```
name,description,price,primary_category,second_category,model_number,upc,sku
"Product 1","description of product 1",12.99,"Electronics","Gadget","12345","1232345345","sku383744"
````

CURL Example
To upload a CSV file via curl, use the following command:

```
curl -X POST -F 'file=@path_to_your_file.csv' http://localhost:3000/products
````

Setting Up the ProductsController
Here's a basic setup for your ProductsController to handle file uploads:

```
# app/controllers/products_controller.rb
class ProductsController < ApplicationController
  require 'csv'

  def upload
    file = params[:file]
    CSV.foreach(file.path, headers: true) do |row|
      Product.create(row.to_hash)
    end
    render json: { status: 'Success', message: 'Products uploaded successfully' }, status: :ok
  rescue => error
    render json: { status: 'Error', message: error.message }, status: :unprocessable_entity
  end
end
````

Database Migration
Ensure you have a migration for the products table:

```
rails generate model Product name:string description:string price:decimal primary_category:string second_category:string model_number:string upc:string sku:string
rails db:migrate
````

Testing
To run your tests, use the following command:

```
rspec
````

(Ensure you have written tests in the spec directory for your API endpoints and model validations.)

Additional Notes
Error Handling: The controller includes basic error handling that will catch and report errors related to file processing.
Security Concerns: Make sure to handle file size and content type validation to avoid security risks associated with file uploads.
