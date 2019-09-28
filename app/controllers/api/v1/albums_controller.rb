require 'aws-sdk-s3'  # v2: require 'aws-sdk'
require 'json'

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
    puts params
    s3 = Aws::S3::Client.new({profile: {aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'], aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']}, region: 'us-east-1'})
    # s3.list_objects_v2(bucket: 'sandbox-v3')

    resp = s3.list_objects_v2(bucket: 'sandbox-v3')
    resp.contents.each do |obj|
      puts obj
    end

    @album = Album.find(params[:id])
    render json: @album
  end

  private

  # def s3
  #   # aws_credentials = Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY'])
  #   Aws::S3::Client.new({aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'], aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'], region: 'us-east-1'})
  # end


  def album_params
    params.require(:album).permit(:title)
  end
end
