require "rails_helper"

describe "visiting a movie's reviews" do
  it "shows all of a review's attributes" do
    m = Movie.create movie_attributes
    m2 = Movie.create movie_attributes2
    r = m.reviews.create review_attributes
    r2 = m2.reviews.create review_attributes2
    r3 = m.reviews.create review_attributes
    visit movie_reviews_url(m)

    expect(page).to have_text r.name
    expect(page).to have_text r.stars
    expect(page).to have_text r.comment
    expect(page).to have_text r.location
    expect(page).to have_text r3.location
    expect(page).not_to have_text r2.name
    expect(page).not_to have_text r2.location
  end


end
