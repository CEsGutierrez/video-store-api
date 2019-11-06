class MoviesController < ApplicationController
  INDEX_MOVIE_FIELDS = ["id", "title", "release_date"]
  SHOW_MOVIE_FIELDS = ["id", "title", "overview", "release_date", "inventory", "available_inventory"]
  
  def index
    movies = Movie.all.as_json(only: INDEX_MOVIE_FIELDS)
    render json: movies, status: :ok
  end
  
  def show
    movie = Movie.find_by(id: params[:id])
    
    if movie
      movie.adjust_available_inventory()
      render json: movie.as_json(only: SHOW_MOVIE_FIELDS), status: :found
      return
    else
      render json: {errors: {id: "ID not found"}}, status: :bad_request
      return
    end
  end
  
  def create
    movie = Movie.new(movie_params)
    
    if movie.save
      render json: movie.as_json(only: [:id]), status: :created
      return
    else
      render json: {errors: movie.errors.messages}, status: :not_acceptable
      return
    end
  end
  
  private
  
  def movie_params
    params.require(:movie).permit(:title, :overview, :release_date, :inventory)
  end
end
