require "bundler"
Bundler.setup
require_relative "acme/products/get"
require_relative "acme/products/add"
require_relative "acme/products/list"
require_relative "acme/products/update"
require_relative "acme/products/delete"

puts "Fetching all products..."
all_products = Acme::Products::List.call
puts all_products

puts "Fetching first product ..."
first_product = all_products["products"].first
puts first_product
puts Acme::Products::Get.call(first_product["id"])

puts "Updating first product ..."
puts Acme::Products::Update.call(first_product["id"], title: "new-product-title")

puts "Deleting first product ..."
puts Acme::Products::Delete.call(first_product["id"])

puts "Creating new product ..."
puts Acme::Products::Add.call(title: "product-title", description: "product-description",
                              price: 200)
puts "It works!"
