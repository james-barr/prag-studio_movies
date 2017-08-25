require "rails_helper"

describe "Creating a new movie" do

  before do
    @u = User.create! user_attributes admin: true
    sign_in @u
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
    click_button "Create Movie"
    expect(current_path).to eq(movie_path(Movie.last))
    expect(page).to have_text "New Movie"
    expect(page).to have_selector "p.flash_notice"
  end

  it "does not save an invalid new movie (as admin)" do
    visit new_movie_url
    click_button "Create Movie"
    expect(page).to have_text "error"
    expect(current_path).to eq movies_path
  end
end
