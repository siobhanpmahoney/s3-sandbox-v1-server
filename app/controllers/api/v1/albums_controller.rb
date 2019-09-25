class Api::V1::AlbumsController < ApplicationController

  def index
    @albums = Album.all
    render json: @albums, include: [songs: [:versions]]
  end

  def create
    @album = Album.new(album_params)
    if @album.save
        render json: @album, status: 201
    else
        render json: {error: @album.errors.full_messages}, status: 500
    end
  end

  def show
    @album = Album.find(params[:id])
    render json: @album
  end

  private

  def album_params
    params.require(:album).permit(:title)
  end
end
