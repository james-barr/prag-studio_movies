module MoviesHelper

  def format_gross movie
    movie.flop? ? content_tag(:strong, "Flop!") : number_to_currency(movie.total_gross)
  end

  def show_poster(movie)
    if movie.image_file_name.blank?
      image_tag("placeholder.png", height: 45, width: 80, class: "float-left")
    else
      image_tag(movie.image_file_name, height: 45, width: 80, class: "float-left")
    end
  end

  def display_stars movie
    if movie.avg_stars.nil?
      content_tag(:p, "No Reviews")
    elsif movie.terrible?
      content_tag(:p, "Terrible")
    else
      "*" * movie.avg_stars
    end
  end

  def display_reviews movie
    if movie.reviews.nil?
    else
      movie.recent_reviews
    end
  end

end
