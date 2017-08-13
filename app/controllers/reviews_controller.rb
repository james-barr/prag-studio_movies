class ReviewsController < ApplicationController
  before_action :set_movie

  def index
    @reviews = @movie.reviews
  end

  def new
    @review = @movie.reviews.new
  end

  def create
    @review = @movie.reviews.new(review_params)
    if @review.save
      flash[:success] = "Success! Your review has been posted."
      redirect_to @movie
    else
      render :new
    end
  end

  def show
    @review = @movie.reviews.find(params[:id])
  end

  def destroy
    @review = @movie.reviews.find(params[:id])
    @review.delete
    redirect_to movie_path(@movie)
  end

private

  def review_params
    params.require(:review).permit(:name, :stars, :comment, :location)
  end

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end
end
