# Clean database
User.destroy_all
Category.destroy_all
Product.destroy_all

# Users
admin = User.create!(
  email: "admin@craftersden.ca",
  password: "password",
  role: :admin
)

seller = User.create!(
  email: "seller@craftersden.ca",
  password: "password",
  role: :seller
)

customer = User.create!(
  email: "customer@craftersden.ca",
  password: "password",
  role: :customer
)

# Categories
categories = %w[Fabric Resin Beads Wood].map do |name|
  Category.create!(name: name)
end

# Products
10.times do |i|
  Product.create!(
    name: "Handmade Item ##{i + 1}",
    description: "This is a unique, hand-crafted item perfect for gifting or decorating.",
    price: rand(10..50),
    stock_quantity: rand(5..20),
    category: categories.sample,
    seller: seller
  )
end

puts "✅ Seed complete: 3 users, 4 categories, 10 products"
