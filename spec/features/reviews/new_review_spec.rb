require "rails_helper"

describe "Create a new review - " do

  before do
    @u = User.create! user_attributes
    sign_in @u
  end

  it "saves a valid review and redirects" do
    m = Movie.create movie_attributes
    visit new_movie_review_url(m)
    fill_in "Location", with: "Ohio"
    fill_in "Comment", with: ""
    choose 'review_stars_5'
    click_button "Create"
    expect(current_path).to eq movie_path(m)
    expect(page).to have_text "Success"
    expect(page).to have_selector "p.flash_success"
  end

  it "does not save an invalid review" do
    m = Movie.create movie_attributes
    visit new_movie_review_url(m)
    click_button "Create"
    expect(page).to have_text "error"
    expect(page).to have_selector "section.error"
    expect(current_path).to eq movie_reviews_path(m)
  end

end
