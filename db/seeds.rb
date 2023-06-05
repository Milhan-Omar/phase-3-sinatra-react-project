puts "🌱 Seeding users..."
User.destroy_all
Todo.destroy_all

5.times do
  user = User.create(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: Faker::Internet.password,
  )
end

puts "✅ Done seeding!"
puts "create your own todos"
