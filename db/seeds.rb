# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

u1 = User.create(email: 'user@example.com', password: 'password')
u2 = User.create(email: 'user2@example.com', password: 'password')
 
p1 = u1.posts.create(title: 'First Post', body: 'An Airplane')
p2 = u1.posts.create(title: 'Second Post', body: 'A Train')
 
p3 = u2.posts.create(title: 'Third Post', body: 'A Truck')
p4 = u2.posts.create(title: 'Fourth Post', body: 'A Boat')
 
p3.comments.create(body: "This post was terrible", user: u1)
p4.comments.create(body: "This post was the best thing in the whole world", user: u1)

# i1 =  User.first.image.attach(io: File.open(File.join(Rails.root, "app/assets/images/cat1.jpeg")), filename: "profile.jpeg")
