def review_attributes(override = {})
  {
    name: "Mark",
    stars: 5,
    comment: "What a great movie, I almost watched it!",
    location: "OH",
  }.merge override
end
def review_attributes2(override = {})
  {
    name: "Carol Schwek",
    stars: 1,
    comment: "I don't normally watch movies, but when I do, it's this movie.",
    location: "China",
  }.merge override
end
def review_attributes3(override = {})
  {
    name: "Dave, Moneyman",
    stars: 3,
    comment: "",
    location: "Orlando, FL",
  }.merge override
end
