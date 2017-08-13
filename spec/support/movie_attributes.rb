def movie_attributes override = {}
  {
    title: "Iron Man",
    rating: "R",
    total_gross: 318_412_101.00,
    description: "Tony Stark builds an armored suit to fight the throes of evil",
    released_on: "2008-05-02",
    cast: "Who Cares",
    director: "Probably a man",
    duration: "1 hour+",
    image_file_name: "ironman.png"
  }.merge override
end

def movie_attributes2(override = {})
  {
    title: "Superman",
    rating: "PG",
    total_gross: 134_218_018.00,
    description: "Clark Kent grows up to be the greatest super-hero of all time",
    released_on: "1978-12-15",
    cast: "Clark Kent",
    director: "Dorkus Badington",
    duration: "Too long",
    image_file_name: "superman.png"
  }.merge override
end

def movie_attributes3(override = {})
  {
    title: "Spider-Man",
    rating: "PG-13",
    total_gross: 403_706_375.00,
    description: "Peter Parker gets bit by a genetically modified spider",
    released_on: "2002-05-03",
    cast: "Peter Parker",
    director: "The dead horse",
    duration: "1 hour and some minutes",
    image_file_name: "spiderman.png"
  }.merge override
end

def movie_attributes4(override = {})
  {
    title: "Future Film",
    rating: "PG-13",
    total_gross: 103_706_375.00,
    description: "Movie you can't see, yet, and hopefully never will.",
    cast: "Sean",
    director: "Mike",
    duration: "Time",
    released_on: "2070-05-03"
  }.merge override
end
