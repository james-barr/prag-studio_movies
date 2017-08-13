module ReviewsHelper

  def time_since(review)
    time_ago_in_words review.created_at
  end

end
