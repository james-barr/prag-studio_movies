class Movie < ApplicationRecord
  has_many :reviews, dependent: :destroy

  Ratings = %w(R PG G PG-13)

  validates :title, :released_on, :duration, presence: true

  validates :rating, inclusion: { in: Ratings,
    message: "Rating must be R, PG, PG-13, or G"}

  validates :total_gross, numericality: { only_integer: true,
    greater_than_or_equal_to: 0}

  validates :description, length: { minimum: 25, maximum: 150}

  validates :cast, format: { with: /\A([a-zA-Z]+,?)(\s?[a-zA-Z]*\s?,?)*([a-zA-Z]+)\z/, message: "Only letters in the cast names, please" }

  validates :director, format: { with: /\A([a-zA-Z]+)(\s?[a-zA-Z]*\s?)*([a-zA-Z]+)\z/, message: "Only letters in the cast names, please" }

  validates :image_file_name, format: { with: /.+\.(gif|png|jpg)\z/i,
     message: "File must end in JPG, PNG, or GIF"}, allow_blank: true

  def flop?
    if total_gross.nil?
      true
    elsif total_gross < 50_000_000 && reviews.count < 5
      true
    else
      false
    end
  end

  def self.previously_released
    where("released_on <= ?", Date.today).order("released_on")
  end

  def avg_stars
    reviews.average(:stars)
  end

  def terrible?
    reviews.average(:stars) < 2.0
  end

  def recent_reviews
    reviews.order(:created_at).limit(2)
  end


end
