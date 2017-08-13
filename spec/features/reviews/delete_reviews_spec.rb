require 'rails_helper'

describe "Deleting a review" do
  it "deletes a review without messing up the movie or other reviews, then redirects to reviews index" do
    m = Movie.create movie_attributes
    r1 = m.reviews.create review_attributes
    r2 = m.reviews.create review_attributes2
    visit movie_review_path(m, r1)
    click_button "Delete Review"
    expect(current_path).to eq movie_reviews_path(m)
    expect(page).to have_text r2.name
    expect(page).not_to have_text r1.name
  end


end
