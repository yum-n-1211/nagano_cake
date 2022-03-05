class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!

  def create
    @genre = Genre.new(genre_params)
    @genre.save
    redirect_to admin_genres_path
  end

  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    @genre.update(genre_params)
    redirect_to admin_genres_path

  end

  private
  # ストロングパラメータ
  def genre_params
    params.require(:genre).permit(:name)

  end

end
