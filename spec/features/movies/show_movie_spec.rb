require "rails_helper"

describe "viewing a movie" do
  it "shows a movie's details" do
    movie = Movie.create(movie_attributes(total_gross: 300000000))
  visit movie_url(movie)

    expect(page).to have_text movie.title
    expect(page).to have_text movie.rating
    expect(page).to have_text movie.description
    expect(page).to have_text movie.released_on
  end

  it "shows if a movie was a flop (Grossed under $50m)" do
    movie = Movie.create movie_attributes(total_gross: 10)

    visit movie_url(movie)

    expect(page).to have_text("Flop!")
  end

  it "shows the total gross, in dollars, if the movie was not a flop (Grossed over $50m)" do
    movie = Movie.create movie_attributes(total_gross: 90_000_000)

    visit movie_url(movie)

    expect(page).to have_text("$90,000,000")
  end

  it "shows the provided image" do
    movie = Movie.create movie_attributes

    visit movie_url(movie)

    expect(page).to have_selector "img[src*=ironman]"
  end

  it "shows the placeholder image" do
    movie = Movie.create movie_attributes4

    visit movie_url(movie)

    expect(page).to have_selector "img[src*=placeholder]"
  end

  it "shows the review form and allows valid reviews to pass, along with
  redirect and flash" do
    m = Movie.create movie_attributes
    visit movie_url(m)
    fill_in "Name", with: "Mike"
    fill_in "Location", with: "Ohio"
    fill_in "Comment", with: ""
    choose 'review_stars_5'

    click_button "Create"
    expect(current_path).to eq movie_path(m)
    expect(page).to have_text "Success"
    expect(page).to have_selector "p.flash_success"
  end

  it "shows the review form and does not allow invalid submissions, but
  provides error messages" do
    m = Movie.create movie_attributes
    visit movie_url(m)
    click_button "Create"
    expect(page).to have_text "error"
    expect(page).to have_selector "section.error"
    expect(current_path).to eq movie_reviews_path(m)
  end

  it "shows 'Terrible' if the rating was < 2" do
    m = Movie.create movie_attributes
    r = m.reviews.create review_attributes(stars: 1)
    visit movie_path(m)
    expect(page).to have_text "Terrible"
  end

  it "shows 'No Reviews' if the there are no reviews" do
    m = Movie.create movie_attributes
    visit movie_path(m)
    expect(page).to have_text "No Reviews"
  end

  it "shows number of stars if the the avg review > 2 stars" do
    m = Movie.create movie_attributes
    r = m.reviews.create review_attributes(stars: 5)
    visit movie_path(m)
    expect(page).to have_text "*****"
  end

  it "it shows the 2 most recent reviews, if there are 2" do
    m = Movie.create movie_attributes
    r1 = m.reviews.create review_attributes
    r2 = m.reviews.create review_attributes2
    visit movie_url(m)
    expect(page).to have_text r1.name
    expect(page).to have_text r1.comment
    expect(page).to have_text r1.location
    expect(page).to have_text r1.stars
    expect(page).to have_text r2.name
    expect(page).to have_text "Most Recent Reviews"
  end

  it "doesn't show anything about recent reviews, if no reviews" do
    m = Movie.create movie_attributes
    visit movie_path(m)
    expect(page).not_to have_text "Most Recent Reviews"
  end


end
