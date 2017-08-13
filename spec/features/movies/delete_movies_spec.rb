require "rails_helper"

describe "Deleting a movie" do
  it "deletes movie and redirects to index" do
    movie = Movie.create movie_attributes

    visit movie_url(movie)

    click_link "Delete Movie"

    expect(current_path).to eq(movies_path)
    expect(page).not_to have_text(movie.title)
    expect(page).to have_selector "p.flash_danger"
  end

end
