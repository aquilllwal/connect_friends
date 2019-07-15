# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(username:  "Aquil",
    email: "aquilhussain15@gmail.com",
    password:"password",
    admin: true)

50.times do |n|
username  = Faker::Name.name
email = "example-#{n+1}@gmail.com"
password = "password"
User.create!(username:  username,
      email: email,
      password: password)
end

users = User.order(:created_at).take(6)
50.times do
  body = Faker::Lorem.sentence(5)
  users.each { |user| user.posts.create!(body: body) }
end