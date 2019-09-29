class Api::V1::VersionsController < ApplicationController

  def index
    @versions = Version.all
    render json: @versions
  end

  def create
    @version = Version.new(version_params)
    if @version.save
        render json: @version, status: 201
    else
        render json: {error: @version.errors.full_messages}, status: 500
    end
  end

  def show
    @version = Version.find(params[:id])
    render json: @version
  end

  def update
    @version = Version.find(params[:id])
    @version.update(version_params)
    if @version.save
      render json: @version
    else
      render json: {error: @version.error.full_messages}
    end
  end

  def destroy
    @version = Version.find(params[:id])
    @version.destroy
    render json: {message: "Version deleted"}
  end

  private

  def version_params
    params.require(:version).permit(:date, :description, :s3_key, :etag, :song_id)
  end
end
