require "rails_helper"

describe "Filtering through scopes" do

  it "returns upcoming movies" do
    m = Movie.create! movie_attributes released_on: Date.tomorrow
    visit filter_movies_path(:upcoming)
    e(current_path).to eq filter_movies_path(:upcoming)
  end

  it "returns hit movies" do
    m = Movie.create! movie_attributes released_on: Date.yesterday, total_gross: 300_000_000
    visit filter_movies_path(:hits)
    e(current_path).to eq filter_movies_path(:hits)
  end

end
