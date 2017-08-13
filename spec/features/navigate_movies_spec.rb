require "rails_helper"

describe "Navigating Events" do
  it "navigates between show and index" do
    movie = Movie.create(movie_attributes(title: "Cat Movie"))

    visit movie_url(movie)

    click_link "All Movies"

    expect(current_path).to eq(movies_path)
  end

  it "navigates between index and show" do
    movie = Movie.create(movie_attributes)

    visit movies_url

    click_link movie.title

    expect(current_path).to eq(movie_path(movie))
  end

  it "navigates from show to edit" do
    movie = Movie.create movie_attributes

    visit movie_url(movie)

    click_link "Edit"

    expect(current_path).to eq(edit_movie_path(movie))
  end

  it "navigates from index to new" do
    visit movies_url

    click_link "Add New Movie"

    expect(current_path).to eq(new_movie_path)
  end

  it "navigates from new to index via cancel button" do
    visit new_movie_url

    click_link "Cancel"

    expect(current_path).to eq(movies_path)
  end

  it "navigates from movie show to review index" do
    m = Movie.create movie_attributes
    r = m.reviews.create review_attributes
    visit movie_url(m)
    click_link "Movie reviews"
    expect(current_path).to eq movie_reviews_path(m)
  end

  it "navigates from review index to movie show" do
    m = Movie.create movie_attributes
    r = m.reviews.create review_attributes
    visit movie_reviews_url(m)
    click_link "Back to movie"
    expect(current_path).to eq movie_path(m)
  end

  it "navigates from movie show to review new" do
    m = Movie.create movie_attributes
    visit movie_url(m)
    click_link "Write review"
    expect(current_path).to eq new_movie_review_path(m)
  end

  it "navigates from review new to movie index" do
    m = Movie.create movie_attributes
    visit new_movie_review_url(m)
    click_link "Cancel"
    expect(current_path).to eq movie_path(m)
  end

end
