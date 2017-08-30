# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Movie.create! ([
  {
    title: "Iron Man",
    rating: "PG-13",
    total_gross: 318412101.00,
    description: "Tony Stark builds an armored suit to fight the throes of evil",
    released_on: "2008-05-02",
    duration: "Long",
    cast: "Dudes and chicks",
    director: "Batman",
  },
  {
    title: "Spider Man",
    rating: "PG-13",
    total_gross: 398413301.00,
    description: "Nerd gains webs and uses them to vandalize New York",
    released_on: "2009-01-05",
    duration: "Awhile",
    cast: "Humans",
    director: "The Rock"
  },
  {
    title: "Super Man",
    rating: "PG",
    total_gross: 199512101.00,
    description: "Clark Kent grows up to be Super Man in America",
    released_on: "2012-12-12",
    duration: "Dos horas",
    cast: "People",
    director: "Stone Cold Steve Austin",
  },
])
m1 = Movie.find(1)
m2 = Movie.find(2)
m3 = Movie.find(3)

User.create!([
  {
    name: "Admin",
    email: "a@f",
    username: "admin",
    password: "x",
    password_confirmation: "x",
    admin: true
  },
  {
    name: "Jon",
    email: "j@f",
    username: "jon",
    password: "x",
    password_confirmation: "x",
  },
  {
    name: "Bob",
    email: "b@f",
    username: "bob",
    password: "x",
    password_confirmation: "x",
  },
  ])
u1 = User.find(1)
u2 = User.find(2)
u3 = User.find(3)

r1 = m1.reviews.create!(
  stars: 3,
  comment: "I ate milk duds out of the cupholder.",
  location: "CO",
  user: u1
)
r2 = m1.reviews.create!(
  stars:4,
  comment: "This was an amazing documentary about an amazing man.",
  location: "Mexico",
  user: u2
)
r3 = m2.reviews.create!(
  stars: 3,
  comment: "This is a review, about a film that was made.",
  location: "Mexico",
  user: u3
)

f1 = m1.favorites.create! user: u1
f2 = m2.favorites.create! user: u1
f3 = m3.favorites.create! user: u1
f4 = m1.favorites.create! user: u2
f5 = m1.favorites.create! user: u3

Genre.create! ([
  {
    name: "Superhero"
  },
  {
    name: "Action"
  },
  {
    name: "Horror"
  },
  {
    name: "Suspense"
  },
  {
    name: "Comedy"
  },
])
g1 = Genre.find 1
g2 = Genre.find 2
g3 = Genre.find 3
g4 = Genre.find 4
g5 = Genre.find 5
mg1 = m1.genre_ids = [1,2,5]
mg2 = m2.genre_ids = [1,2]
mg3 = m3.genre_ids = [1,2]
