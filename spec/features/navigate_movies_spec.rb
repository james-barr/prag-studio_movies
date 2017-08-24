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

  it "navigates from movie index to users Sign Up" do
    visit movies_path
    click_link "Sign Up"
    e(current_path).to eq signup_path
  end

  it "navigates from movie show to users index" do
    u = User.create! user_attributes
    m = Movie.create! movie_attributes
    visit movie_path(m)
    click_link "All Users"
    sign_in u
    e(current_path).to eq users_path
  end

  it "navigates from user signup to user index" do
    visit signup_path
    click_link "Cancel"
    e(current_path).to eq root_path
  end

  it "navigates from user index to user show" do
    u = User.create! user_attributes
    sign_in u
    visit users_path
    click_link u.name, match: :first
    e(current_path).to eq user_path(u)
  end

  it "navigates from user show to user edit" do
    u = User.create! user_attributes
    sign_in u
    visit user_path(u)
    click_link "Edit Account"
    e(current_path).to eq edit_user_path(u)
  end

  it "navigates from events index to Sign In" do
    visit movies_path
    click_link "Sign In"
    e(current_path).to eq signin_path
  end

  it "navigates from sign in to sign up" do
    visit signin_path
    click_link "Sign Up", match: :first
    e(current_path).to eq signup_path
  end


end
