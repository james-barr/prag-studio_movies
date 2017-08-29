class FavoritesController < ApplicationController
  before_action :require_signin
  before_action :find_movie

  def create
    @fav = @movie.favorites.new user: current_user
    if @fav.save!
      redirect_to @movie, notice: "Favorited"
    else
      render @movie, alarm: "Already Favorited"
    end
  end

  def destroy
    @fav = current_user.favorites.find_by movie_id: @movie
    @fav.delete
    redirect_to @movie, alert: "Unfavorited"
  end

private
  def find_movie
    @movie = Movie.find(params[:movie_id])
  end

end
