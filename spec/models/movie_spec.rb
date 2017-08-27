require "rails_helper"

describe "A Movie" do

  before do
    @u1 = User.create! user_attributes
    @u2 = User.create! user_attributes2
  end

  it "is a flop if the total gross is < $50m and not a cult classic (ie < 5 reviews)" do
    movie = Movie.new(total_gross: 10)
    expect(movie.flop?).to eq(true)
  end

  it "is NOT a flop if the total gross is < $50m and not a cult classic (ie > 5 reviews)" do
    u3 = User.create! user_attributes3
    u4 = User.create! user_attributes name: "X2", email: "x@u", username: "X2"
    u5 = User.create! user_attributes name: "X1", email: "x1@u", username: "X1"
    movie = Movie.create movie_attributes(total_gross: 10)
    r1 = movie.reviews.new review_attributes
    r2 = movie.reviews.new review_attributes
    r3 = movie.reviews.new review_attributes
    r4 = movie.reviews.new review_attributes
    r5 = movie.reviews.new review_attributes
    r1.user = @u1; r1.save!
    r2.user = @u2; r2.save!
    r3.user = u3; r3.save!
    r4.user = u4; r4.save!
    r5.user = u5; r5.save!
    expect(movie.flop?).to eq false
  end

  it "is not a flop if the total gross is > $50m" do
    movie = Movie.new(total_gross: 100_000_000)
    expect(movie.flop?).to eq(false)
  end

  it "is a flop if the total gross is blank" do
    movie = Movie.new(total_gross: nil)
    expect(movie.flop?).to eq(true)
  end

  it "shows previously released movies, only and in order" do
    movie1 = Movie.create movie_attributes(released_on: "2070-01-01")
    movie2 = Movie.create movie_attributes(released_on: "2007-01-01")
    movie3 = Movie.create movie_attributes(released_on: "2001-01-01")
    movie4 = Movie.create movie_attributes(released_on: "2017-01-01")
    expect(Movie.previously_released.to_a).to eq([movie3, movie2, movie4])
  end

  it "validates that a movie title cannot be blank" do
    movie = Movie.new title: ""
    movie.valid?
    expect(movie.errors[:title].any?).to eq true
  end

  it "validates that a movie title can be type of string" do
    title = %w( mike MOLLY 16 0.1)
    title.each do |title|
      movie = Movie.new title: title
      movie.valid?
      expect(movie.errors[:title].any?).to eq false
    end
  end

  it "validates that a movie can only be rated according to approved list" do
    movie = Movie.new rating: "X"
    movie.valid?
    expect(movie.errors[:rating].any?).to eq true
  end

  it "validates that a rating cannot be blank" do
    movie = Movie.new rating: ""
    movie.valid?
    expect(movie.errors[:rating].any?).to eq true
  end

  it "validates that total gross is >= zero" do
    movie = Movie.new total_gross: -1
    movie.valid?
    expect(movie.errors[:total_gross].any?).to eq true
  end

  it "validates that total gross is an integer" do
    movie = Movie.new total_gross: 100.11
    movie.valid?
    expect(movie.errors[:total_gross].any?).to eq true
  end

  it "validates that description is at least 25 characters" do
    movie = Movie.new description: ""
    movie.valid?
    expect(movie.errors[:description].any?).to eq true
  end

  it "Validates that description is no more than 150 characters" do
    movie = Movie.new description: "1234567890 1234567890 1234567890 1234567890
    1234567890 1234567890 1234567890 1234567890 1234567890 1234567890 1234567890
    1234567890 1234567890 1234567890 1234567890 1234567890"
    movie.valid?
    expect(movie.errors[:description].any?).to eq true
  end

  it "validates that released_on is not blank" do
    movie = Movie.new released_on: ""
    movie.valid?
    expect(movie.errors[:released_on].any?).to eq true
  end

  it "validates that cast is not blank" do
    movie = Movie.new cast: ""
    movie.valid?
    expect(movie.errors[:cast].any?).to eq true
  end

  it "does not allow for non-matching casts" do
    cast = ["Frank the 3rd", "  M  ", " 1abcd", "m ", " m", "    "]
    cast.each do |cast|
      movie = Movie.new cast: cast
      movie.valid?
      expect(movie.errors[:cast].any?).to eq true
    end
  end

  it "allows for matching casts" do
    cast = ["Frank", "Charra Deville", "Mark, Carry",
      "Sean, Franklin Moore, AlexisSmart", "The team of brothers"]
    cast.each do |cast|
      movie = Movie.new cast: cast
      movie.valid?
      expect(movie.errors[:cast].any?).to eq false
    end
  end

  it "does not allow for non-matching director" do
    director = ["Frank the 3rd", "  M  ", " 1abcd", "m ", " m", "    ", 1,
      "Ken_Star", "Mark, Carry" ]
    director.each do |director|
      movie = Movie.new director: director
      movie.valid?
      expect(movie.errors[:director].any?).to eq true
    end
  end

  it "allows for matching director" do
    director = ["MaraShkl", "Tom The Deville", "The team of brothers"]
    director.each do |director|
      movie = Movie.new director: director
      movie.valid?
      expect(movie.errors[:director].any?).to eq false
    end
  end

  it "validates the presence of duration" do
    movie = Movie.new duration: ""
    movie.valid?
    expect(movie.errors[:duration].any?).to eq true
  end

  it "allows image file name to be blank" do
    movie = Movie.new image_file_name: ""
    movie.valid?
    expect(movie.errors[:image_file_name].any?).to eq false
  end

  it "disallows that image file not ending in match fails" do
    image = ["x.zz", "y,png", "z.pngg", ".jpg"]
    image.each do |image|
      movie = Movie.new image_file_name: image
      movie.valid?
      expect(movie.errors[:image_file_name].any?).to eq true
    end
  end

  it "validates that image files ending in match pass" do
    image = ["..jpg", "cat.gif", "1.PNG"]
    image.each do |image|
      movie = Movie.new image_file_name: image
      movie.valid?
      expect(movie.errors[:image_file_name].any?).to eq false
    end
  end

  it "has many reviews" do
    m = Movie.create movie_attributes
    r1 = m.reviews.new review_attributes
    r2 = m.reviews.new review_attributes2
    r1.user = @u1; r2.user = @u2
    r1.save!; r2.save!
    expect(m.reviews.count).to eq 2
  end

  it "deletes associated reviews when deleted" do
    m = Movie.create movie_attributes
    r1 = m.reviews.new review_attributes
    r1.user = @u1; r1.save!
    expect{m.destroy}.to change(Review, :count).by(-1)
  end

  it "determines the movie's average rating" do
    m = Movie.create movie_attributes
    r1 = m.reviews.new review_attributes
    r2 = m.reviews.new review_attributes2
    r1.user = @u1; r1.save!
    r2.user = @u2; r2.save!
    expect(m.avg_stars).to eq 3
  end

  it "determines if the movie was terrible" do
    m = Movie.create movie_attributes
    r1 = m.reviews.new review_attributes(stars: 1)
    r2 = m.reviews.new review_attributes2(stars: 2)
    r1.user = @u1; r1.save!
    r2.user = @u2; r2.save!
    expect(m.terrible?).to eq true
  end

  it "determines if the movie wasn't terrible" do
    m = Movie.create movie_attributes
    r1 = m.reviews.new review_attributes(stars: 4)
    r2 = m.reviews.new review_attributes2(stars: 5)
    r1.user = @u1; r1.save!
    r2.user = @u2; r2.save!
    expect(m.terrible?).to eq false
  end

  it "finds the 2 most recent reviews" do
    m = Movie.create movie_attributes
    r1 = m.reviews.new review_attributes
    r2 = m.reviews.new review_attributes2
    r1.user = @u1; r1.save!
    r2.user = @u2; r2.save!
    expect(m.recent_reviews.length).to eq 2
  end

end
