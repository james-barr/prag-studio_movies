require "rails_helper"

describe "Favoriting a movie" do

  before do
    @movie = Movie.create! movie_attributes
    @user = User.create! user_attributes
    sign_in @user
  end

  it "doesn't show fav or unfave if not signed in" do
    visit movie_path @movie
    click_link "Sign Out"
    e(page).not_to have_link "Fave"
    e(page).not_to have_link "Unfave"
  end

  it "shows fav button if user has not favorited movie" do
    visit movie_path @movie
    e(page).to have_text "0 favorites"
    expect{
      click_button "Fave"
    }.to change(@movie.favorites, :count).by 1
    e(page).to have_text "1 favorite"
    e(page).to have_button "Unfave"
    e(page).to have_text "Favorited"
  end

  it "shows unfav button if user has favorited movie" do
    visit movie_path @movie
    click_button "Fave"
    e(page).to have_text "1 favorite"
    expect{
      click_button "Unfave"
    }.to change(@movie.favorites, :count).by -1
    e(page).to have_text "0 favorites"
    e(page).to have_button "Fave"
    e(page).to have_text "Unfavorited"
  end

end
