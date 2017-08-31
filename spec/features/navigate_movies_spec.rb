require "rails_helper"

describe "Navigating Events" do

  before do
    @m = Movie.create! movie_attributes
    @u = User.create! user_attributes admin: true
    sign_in @u
  end

  it "navigates between show and index" do
    visit movie_url(@m)
    click_link "Released Movies"
    expect(current_path).to eq(movies_path)
  end

  it "navigates between index and show" do
    visit movies_url
    click_link @m.title
    expect(current_path).to eq(movie_path(@m))
  end

  it "navigates from movie show to movie edit (as admin)" do
    visit movie_url(@m)
    click_link "Edit"
    expect(current_path).to eq(edit_movie_path(@m))
  end

  it "navigates from movie index to movie new (as admin)" do
    visit movies_url
    click_link "Add New Movie"
    expect(current_path).to eq(new_movie_path)
  end

  it "navigates from new to index via cancel button (as admin)" do
    visit new_movie_url
    click_link "Cancel"
    expect(current_path).to eq(movies_path)
  end

  it "navigates from movie show to review index" do
    r = @m.reviews.create review_attributes user: @u
    visit movie_url(@m)
    click_link "Movie reviews"
    expect(current_path).to eq movie_reviews_path(@m)
  end

  it "navigates from review index to movie show" do
    r = @m.reviews.create review_attributes user: @u
    visit movie_reviews_url(@m)
    click_link "Back to movie"
    expect(current_path).to eq movie_path(@m)
  end

  it "navigates from movie show to review new" do
    visit movie_url(@m)
    click_link "Write review"
    expect(current_path).to eq new_movie_review_path(@m)
  end

  it "navigates from review new to movie index" do
    visit new_movie_review_url(@m)
    click_link "Cancel"
    expect(current_path).to eq movie_path(@m)
  end

  it "navigates from movie index to users Sign Up" do
    click_link "Sign Out"
    visit movies_path
    click_link "Sign Up"
    e(current_path).to eq signup_path
  end

  it "navigates from movie show to users index" do
    visit movie_path(@m)
    click_link "All Users"
    e(current_path).to eq users_path
  end

  it "navigates from user signup to user index" do
    click_link "Sign Out"
    visit signup_path
    click_link "Cancel"
    e(current_path).to eq root_path
  end

  it "navigates from user index to user show" do
    visit users_path
    click_link @u.name, match: :first
    e(current_path).to eq user_path(@u)
  end

  it "navigates from user show to user edit" do
    visit user_path(@u)
    click_link "Edit Account"
    e(current_path).to eq edit_user_path(@u)
  end

  it "navigates from events index to Sign In" do
    visit movies_path
    click_link "Sign Out"
    click_link "Sign In"
    e(current_path).to eq signin_path
  end

  it "navigates from sign in to sign up" do
    visit signin_path
    click_link "Sign Out"
    click_link "Sign Up", match: :first
    e(current_path).to eq signup_path
  end


end
