# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
motorcycles_data = [
  { name: 'Harley Davidson', image: 'https://image.kilimall.com/kenya/shop/store/goods/7442/2021/07/7442_06801939004978952_720.jpg.webp', amount: 200, duration: 3,description:"This is a superbike" },
  { name: 'Honda', image: 'https://image.kilimall.com/kenya/shop/store/goods/7442/2021/07/7442_06801939004978952_720.jpg.webp', amount: 150, duration: 2,description: "This is a superbike"},
  { name: 'Yamaha', image: 'https://image.kilimall.com/kenya/shop/store/goods/7442/2021/07/7442_06801939004978952_720.jpg.webp', amount: 180, duration: 2,description: "This is a superbike" },
  { name: 'Kawasaki', image: 'https://image.kilimall.com/kenya/shop/store/goods/7442/2021/07/7442_06801939004978952_720.jpg.webp', amount: 170, duration: 2,description: "This is a superbike" },
  { name: 'Suzuki', image: 'https://image.kilimall.com/kenya/shop/store/goods/7442/2021/07/7442_06801939004978952_720.jpg.webp', amount: 160, duration: 1,description: "This is a superbike" }
]
motorcycles_data.each do |motorcycle_data|
  Motorcycle.create(motorcycle_data)
end

puts "Motorcycles created successfully."