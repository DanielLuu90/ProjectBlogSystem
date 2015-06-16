
User.create!(
  name: 'Truc',
  email: 'truclh@hotmail.com',
  password: "123456",
  password_confirmation: "123456",
)
99.times do |n|
  name = Faker::Name.name
  email = "examplesm#{n+1}@examples.com"
  password = "password"
  User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password,
  )
end

users = User.order(:created_at).take(6)
96.times do
  name = Faker::Lorem.sentence(3)
  content_entry = Faker::Lorem.sentence(5)
  users.each { |user| user.entries.create!(content_entry: content_entry ) }
end

users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }