require "rails_helper"

describe "Deleting a movie" do

  before do
    @u = User.create! user_attributes admin: true
    sign_in @u
  end

  it "deletes movie and redirects to index (as admin)" do
    movie = Movie.create movie_attributes
    visit movie_url(movie)
    click_link "Delete Movie"
    expect(current_path).to eq(movies_path)
    expect(page).not_to have_text(movie.title)
    expect(page).to have_selector "p.flash_danger"
  end

end
