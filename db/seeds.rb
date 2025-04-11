# Clean database
puts "🧼 Cleaning database..."

puts "Destroying products..."
Product.destroy_all

puts "Destroying categories..."
Category.destroy_all

puts "Destroying users..."
User.destroy_all

puts "Destroying provinces..."
Province.destroy_all

# Create a default province
puts "🌾 Creating province..."
manitoba = Province.create!(
  name: "Manitoba",
  gst: 0.05,
  pst: 0.07,
  hst: 0.0
)

# Users with province assigned
puts "👤 Creating users..."
admin = User.create!(
  email: "admin@craftersden.ca",
  password: "password",
  role: :admin,
  province: manitoba
)

seller = User.create!(
  email: "seller@craftersden.ca",
  password: "password",
  role: :seller,
  province: manitoba
)

customer = User.create!(
  email: "customer@craftersden.ca",
  password: "password",
  role: :customer,
  province: manitoba
)

# Create categories
puts "📁 Creating categories..."
category1 = Category.create!(name: "Woodworking")
category2 = Category.create!(name: "Sewing")
category3 = Category.create!(name: "Painting")
category4 = Category.create!(name: "Beading")
category5 = Category.create!(name: "Knitting")

# Create products using Faker
puts "🛍 Creating faker products..."
100.times do
  Product.create!(
    name: Faker::Commerce.product_name,
    description: Faker::Lorem.paragraph(sentence_count: 3),
    price: Faker::Commerce.price(range: 10..100.0),
    stock_quantity: Faker::Number.between(from: 1, to: 50),
    category: [ category1, category2, category3, category4, category5 ].sample,
    seller: seller
  )
end

# Create non-Faker products
puts "🧵 Creating 10 non-Faker products..."
Product.create!([
  { name: "Handcrafted Wooden Chair", description: "A beautifully crafted chair made from solid oak wood, perfect for any living room.", price: 75.00, stock_quantity: 20, category: category1, seller: seller },
  { name: "Sewing Kit Deluxe", description: "All the essentials for sewing, including needles, thread, and scissors.", price: 25.00, stock_quantity: 50, category: category2, seller: seller },
  { name: "Oil Painting Set", description: "A complete set for beginners to create stunning oil paintings.", price: 45.00, stock_quantity: 30, category: category3, seller: seller },
  { name: "Beaded Necklace", description: "A handmade necklace featuring intricate beadwork in a variety of vibrant colors.", price: 35.00, stock_quantity: 10, category: category4, seller: seller },
  { name: "Knitted Wool Scarf", description: "Soft and cozy scarf hand-knitted from high-quality wool.", price: 20.00, stock_quantity: 15, category: category5, seller: seller },
  { name: "Rustic Wooden Shelf", description: "A sturdy, handcrafted wooden shelf with a rustic finish. Perfect for home decoration.", price: 50.00, stock_quantity: 25, category: category1, seller: seller },
  { name: "Sewing Machine", description: "A high-quality, versatile sewing machine for all your crafting needs.", price: 150.00, stock_quantity: 5, category: category2, seller: seller },
  { name: "Canvas Painting Set", description: "Everything you need to start your journey in painting on canvas: brushes, paints, and a canvas.", price: 40.00, stock_quantity: 40, category: category3, seller: seller },
  { name: "Handmade Beaded Earrings", description: "Elegant beaded earrings designed by local artisans, perfect for special occasions.", price: 28.00, stock_quantity: 12, category: category4, seller: seller },
  { name: "Knitted Wool Blanket", description: "A large, soft blanket hand-knitted from premium wool, perfect for winter.", price: 60.00, stock_quantity: 8, category: category5, seller: seller }
])

puts "✅ Seed data created!"
