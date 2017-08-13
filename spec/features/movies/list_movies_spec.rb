require 'rails_helper'

describe "Viewing the list of movies" do
  it "shows the movies" do
    movie1 = Movie.create(movie_attributes)
    movie2 = Movie.create movie_attributes2
    movie3 = Movie.create movie_attributes3
    movie4 = Movie.create movie_attributes4

    r1 = movie1.reviews.create review_attributes(stars: 1)
    r2 = movie1.reviews.create review_attributes2(stars: 2)
    r3 = movie2.reviews.create review_attributes
    r4 = movie3.reviews.create review_attributes3
    r5 = movie4.reviews.create review_attributes2

    visit movies_url

    expect(page).to have_text "3 Movies"
    expect(page).to have_text movie1.title
    expect(page).to have_text movie2.title
    expect(page).to have_text movie3.title
    expect(page).not_to have_text movie4.title

    expect(page).to have_text movie1.description
    expect(page).to have_text movie1.rating
    expect(page).to have_text "$403,706,375.00"
    expect(page).to have_text movie1.released_on
    expect(page).to have_text movie1.cast
    expect(page).to have_text movie1.director
    expect(page).to have_text movie1.duration
    expect(page).to have_selector "img[src*=ironman]"
    expect(page).to have_text "Terrible"
  end
end
