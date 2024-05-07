require "csv"
require "bigdecimal"
class ProductsController < ApplicationController
  # skip_before_action :verify_authenticity_token, only: [:upload]

  def upload
    file = params[:file]
    CSV.foreach(file, headers: true) do |row|
      puts "=====> reading...."
      puts "=====> Name: #{row}"

      Product.create!(
        {
          name: row["name"],
          description: row["description"],
          price: row["price"],
          primary_category: row["primary_category"],
          second_category: row["second_category"],
          model_number: row["model_number"],
          sku: row["sku"],
          upc: row["upc"]
        }
      )
    rescue ActiveRecord::RecordInvalid => e
      render json: { error: e.message }, status: :unprocessable_entity
      return
    end

    @products =
      Product.all.map do |product|
        {
          name: product.name,
          description: product.description,
          price: product.price,
          primary_category: product.primary_category,
          second_category: product.second_category,
          model_number: product.model_number,
          sku: product.sku,
          upc: product.upc
        }
      end
    render json: @products, status: :created
  end
end
