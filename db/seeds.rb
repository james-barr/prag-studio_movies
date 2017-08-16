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
movie = Movie.find(1)
movie.reviews.create!(
  name: "Mike",
  stars: 3,
  comment: "I ate milk duds out of the cupholder.",
  location: "CO",
)
movie.reviews.create!(
  name: "Sharon",
  stars:4,
  comment: "This was an amazing documentary about an amazing man.",
  location: "Mexico",
)

User.create!([
  {
    name: "Don",
    email: "d@g",
    password: "x",
    password_confirmation: "x",
  },
  {
    name: "Al",
    email: "al@x",
    password: "x",
    password_confirmation: "x",
  },
  {
    name: "Gary",
    email: "g@y",
    password: "y",
    password_confirmation: "y",
  },
  ])
