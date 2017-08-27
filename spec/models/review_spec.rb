require "rails_helper"

describe "A review: " do

  it "validates that valid stars are within the scoring bounds" do
    r = Review.new stars: Review::Rating_stars.sample
    r.valid?
    expect(r.errors[:stars].any?).to eq false
  end

  it "invalidates invalid stars that are not within the scoring bounds" do
    r = Review.new stars: 6
    r.valid?
    expect(r.errors[:stars].any?).to eq true
  end

  it "validates that a comment is at least 25 characters" do
    r = Review.new comment: "Short"
    r.valid?
    expect(r.errors[:comment].any?).to eq true
  end

  it "validates that a comment is no more than 25 characters" do
    r = Review.new comment: "0123456789 0123456789 0123456789
    0123456789 0123456789 0123456789 0123456789 0123456789 0123456789
    0123456789 0123456789 0123456789 0123456789 0123456789 0123456789
    0123456789 0123456789 0123456789"
    r.valid?
    expect(r.errors[:comment].any?).to eq true
  end

  it "validates that a review has a location" do
    r = Review.new location: ""
    r.valid?
    expect(r.errors[:location].any?).to eq true
  end

  it "validates that a review belongs to a movie" do
    m = Movie.new
    r = Review.new movie: m
    r.valid?
    expect(r.errors[:movie].any?).to eq false
  end

  it "validates that a review is valid with all correct attributes" do
    u = User.create! user_attributes
    m = Movie.new movie_attributes
    r = Review.new review_attributes(movie: m)
    r.user = u; r.save!
    r.valid?
    expect(r.errors.any?).to eq false
  end

end
