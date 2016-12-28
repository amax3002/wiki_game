# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Role.create(
  name: "admin"
)
Role.create(
  name: "client"
)

# Create 1 Admin
new_admin = User.create(
  full_name: "Pamela Duke",
  email: "pduke@gmail.com",
  password: "password",
  password_confirmation: "password"
)

#Create 1 regular Client
client = User.create(
  full_name: "Harry Potter",
  email: "hpotter@hogwarts.com",
  password: "password",
  password_confirmation: "password"
)

new_admin.roles << Role.find_by(name: "admin")
client.roles << Role.find_by(name: "client")
