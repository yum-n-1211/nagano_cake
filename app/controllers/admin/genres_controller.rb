class Admin::GenresController < ApplicationController

  def create
    @genre = Genre.new(genre_params)
    @genre.save
    redirect_to admin_genres_path
  end

  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def show
  end

  def edit
  end

  private
  # ストロングパラメータ
  def genre_params
    params.require(:genre).permit(:name)

  end

end
