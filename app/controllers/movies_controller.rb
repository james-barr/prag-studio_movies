class MoviesController < ApplicationController
  before_action :require_signin, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]

  def index
    @movies = Movie.send(movies_scope)
  end

  def show
    @movie = Movie.find(params[:id])
    @review = @movie.reviews.new
    if current_user
      @current_fave = current_user.favorites.find_by movie_id: @movie.id
    end
    @genres = @movie.genres
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update(movie_params)
      redirect_to @movie, notice: "Movie successfully updated"
    else
      render :edit
    end
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to @movie, notice: "Movie successfully created"
    else
      render :new
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.delete
    redirect_to movies_path, danger: "Movie successfully deleted"
  end

private

  def movie_params
    params.require(:movie).permit(:title, :total_gross, :description, :released_on, :rating, :director, :cast, :duration, :image_file_name, genre_ids: [])
  end

  def movies_scope
    if params[:scope].in? %w(upcoming hits)
      params[:scope]
    else
      :released
    end
  end

end
