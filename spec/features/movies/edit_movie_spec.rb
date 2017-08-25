require "rails_helper"

describe "Editing a movie" do

  before do
    @u = User.create! user_attributes admin: true
    sign_in @u
  end

  it "has a form that allows editing of all movie fields (as admin)" do
    movie = Movie.create movie_attributes
    visit edit_movie_url(movie)
    expect(page).to have_text movie.title
    expect(find_field('Title').value).to eq(movie.title)
    expect(find_field('Description').value).to eq(movie.description)
    expect(find_field('Rating').value).to eq(movie.rating)
  end

  it "submits the edit and redirects to show (as admin)" do
    movie = Movie.create movie_attributes
    visit edit_movie_url(movie)
    expect(find_field('Title').value).to eq(movie.title)
    fill_in 'Title', with: "Movie Title"
    click_button 'Update Movie'
    expect(current_path).to eq(movie_path(movie))
    expect(page).to have_text('Movie Title')
    expect(page).to have_selector "p.flash_notice"
  end

  it "does not save an update if invalid (as admin)" do
    movie = Movie.create movie_attributes
    visit edit_movie_url(movie)
    fill_in "Title", with: " "
    click_button "Update Movie"
    expect(page).to have_text "error"
    expect(current_path).to eq movie_path(movie)
  end

end
