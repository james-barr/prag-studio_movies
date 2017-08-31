class Review < ApplicationRecord
  belongs_to :movie
  belongs_to :user

  Rating_stars = [
   1, 2, 3, 4, 5
  ]

  validates :location, presence: true

  validates :stars, inclusion: { in: Rating_stars,
    message: "Rating must be between 1 - 5"}

  validates :comment, length: {minimum: 25, maximum: 150}, allow_blank: true

  scope :past_n_days, -> (n) { where('created_at >= ?', n.days.ago) }
end
