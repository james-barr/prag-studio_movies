require "rails_helper"

describe "visiting a movie's reviews" do

  before do
    @u = User.create! user_attributes
    @u2 = User.create! user_attributes2
  end

  it "shows all of a review's attributes" do
    m = Movie.create movie_attributes
    r = m.reviews.new review_attributes
    r2 = m.reviews.new review_attributes2
    r.user = @u; r.save!
    r2.user = @u2; r2.save!
    visit movie_reviews_url(m)
    expect(page).to have_text r.user.name
    expect(page).to have_text r.stars
    expect(page).to have_text r.comment
    expect(page).to have_text r.location
    expect(page).to have_text r2.location
  end


end
