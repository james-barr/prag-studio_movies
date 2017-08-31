class Movie < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :watchers, through: :favorites, source: :user
  has_many :characterizations, dependent: :destroy
  has_many :genres, through: :characterizations


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

  scope :upcoming, -> { where('released_on > ?', Date.today)}
  scope :released, -> { where('released_on <= ?', Date.today)}
  scope :past_n_days, -> (n=30) { where 'released_on >= ?', n.days.ago}
  scope :rated, -> (rating) { where(rating: rating) }
  scope :grossed_less_than, -> (gross) { where('total_gross < ?', gross)}
  scope :grossed_more_than, -> (gross) { where('total_gross > ?', gross)}
  scope :hits, -> { released.where('total_gross > ?', 200_000_000)}

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
