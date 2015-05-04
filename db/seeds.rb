# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

r1 = Role.create!(name: "Admin", description: "Can manage all")
r2 = Role.create!(name: "Regular", description: "Can read all")

User.create!(
  name: "Example User",
  email: "example@railstutorial.org",
  password: "foobar12",
  password_confirmation: "foobar12",
  role_id: r1.id
)

50.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name,
    email: email,
    password: password,
    password_confirmation: password,
    role_id: r2.id
  )
end

users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each{|followed| user.follow(followed)}
followers.each{|follower| follower.follow(user)}

#Categories
Category.create!(title: "Example Category",
  description: "- Always think how to improve the current code and design more\n
    - Do not asks basic questions\n
    - Do not ask the same a problem many times\n
    - Researches to resolve problems by himself\n
    - Discusses with others in team\n
    - Gives actively the idea about problems in team\n
    - Discusses in lectures\n
    - Ask leader about complex task\n
    - Support others\n
    - Comment on GitHub.")

9.times do
  title = Faker::Lorem.sentence
  description = Faker::Lorem.paragraph
  Category.create! title: title, description: description
end

#Words
categories = Category.take 6
5.times do
  content = Faker::Lorem.word
  categories.each{|category| category.words.create! content: content}
end

#Learned Words
words = Category.first.words.take 3
words.each{|word| User.first.learned_words.create! word_id: word.id}
