require "rails_helper"

describe "visiting a movie's reviews" do

  before do
    @u = User.create! user_attributes
    @u2 = User.create! user_attributes2
    sign_in @u
  end

  it "shows all of a review's attributes" do
    m = Movie.create movie_attributes
    r = m.reviews.create review_attributes user: @u
    r2 = m.reviews.create review_attributes2 user: @u2
    visit movie_reviews_url(m)
    expect(page).to have_text r.user.name
    expect(page).to have_text r.stars
    expect(page).to have_text r.comment
    expect(page).to have_text r.location
    expect(page).to have_text r2.location
  end


end
