require 'csv'

class ProductsController < ApplicationController
  def list
    @products = fetch_products
  end

  def view
@products = fetch_products

    @product = @products.find {|a| a.pid == params[:pid]}
  end

  def fetch_products
    @products =[]

    CSV.foreach("mf_inventory.csv", headers:true) do |row|

    product=Product.new
    product.img_file = row.to_h["img_file"]
    product.item = row.to_h["item"]
    product.price = row.to_h["price"]
    product.pid = row.to_h["pid"]
    product.description = row.to_h["description"]
    product.condition = row.to_h["condition"]
    product.dimension_w = row.to_h["dimension_w"]
    product.dimension_l = row.to_h["dimension_l"]
    product.dimension_h = row.to_h["dimension_h"]
    if row.to_h["quantity"].to_i > 0
    product.quantity = row.to_h["quantity"]
    product.category = row.to_h["category"]

      @products << product
    end
end
@products
end
end
