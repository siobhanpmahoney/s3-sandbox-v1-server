class Api::V1::SongsController < ApplicationController

  def index
    @songs = Song.all
    render json: @songs, include: ['versions']
  end

  def create
    @song = Song.new(song_params)
    if @song.save
        render json: @song, status: 201
    else
        render json: {error: @song.errors.full_messages}, status: 500
    end
  end

  def show
    @song = Song.find(params[:id])
    render json: @song
  end

  def update
    @song = Song.find(params[:id])
    @song.update(song_params)
    if @song.save
      render json: @song
    else
      render json: {error: @song.error.full_messages}
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    render json: {message: "Song deleted"}
  end

  private

  def song_params
    params.require(:song).permit(:title, :album_id)
  end
end
