require "rails_helper"

describe "Creating a new movie" do

  before do
    @u = User.create! user_attributes admin: true
    sign_in @u
    @g1 = Genre.create! name: "G1"
    @g2 = Genre.create! name: "G2"
    @g3 = Genre.create! name: "G3"
  end

  it "has all fields, creates a new movie, and redirects to show page (as admin)" do
    visit new_movie_url
    expect(page).to have_text "Add New Movie"
    fill_in "Title", with: "New Movie"
    select "PG", :from => "Rating"
    fill_in "Description", with: "Some dumb film with lots of bs going on in it"
    fill_in "Total gross", with: "75000000"
    fill_in "Cast", with: "Mike"
    fill_in "Director", with: "Frank"
    fill_in "Duration", with: "1 Hour"
    select (Time.now.year - 1).to_s, :from => "movie_released_on_1i"
    check @g1.name
    check @g2.name
    click_button "Create Movie"
    expect(current_path).to eq(movie_path(Movie.last))
    expect(page).to have_text "New Movie"
    expect(page).to have_selector "p.flash_notice"
    within "aside#sidebar" do
      e(page).to have_text @g1.name
      e(page).to have_text @g2.name
    end
    e(page).not_to have_text @g3.name
    e(page).to have_title "Movies - New Movie"
  end

  it "does not save an invalid new movie (as admin)" do
    visit new_movie_url
    click_button "Create Movie"
    expect(page).to have_text "error"
    expect(current_path).to eq movies_path
  end
end
