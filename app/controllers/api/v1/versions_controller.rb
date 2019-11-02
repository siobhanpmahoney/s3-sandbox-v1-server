require 'open-uri'
require 'aws-sdk-s3'

class Api::V1::VersionsController < ApplicationController
  before_action :set_host_for_local_storage
  wrap_parameters format: [:json, :xml, :url_encoded_form, :multipart_form]



  def index
    @versions = Version.all
    render json: @versions
  end

  def create

    @version = Version.new(song_id: params[:song_id])
    puts params
    # byebug

    if params[:file]
      # s3 = Aws::S3::Resource.new(region:'us-east-1')
      # file = params[:file]
      # bucket = 'sand'
      #
      # obj.upload_file('/path/to/source/file')


      s3 = Aws::S3::Client.new({profile: {aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'], aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']}, region: 'us-east-1'})

      file = params[:file]
      bucket = 'sandbox-v3'
      title = "#{@version.song.album.title}/#{@version.song.title}/#{Time.now}.m4a"

      resp = s3.put_object({
        acl: "authenticated-read",
        body: file,
        bucket: "sandbox-v3",
        key: title,
      })

      @version.update(etag: resp.to_h[:etag], s3_key: title)
    end



    if @version.save
      render json: @version, status: 201
    else
      render json: {error: @version.errors.full_messages}, status: 500
    end
  end

  def show
    @version = Version.find(params[:id])
    object.presigned_url(:get)
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

  def get_presigned_url

    obj.presigned_url(:get, expires_in: 3600)
  end

  private

  def set_host_for_local_storage
  ActiveStorage::Current.host = request.base_url if Rails.application.config.active_storage.service == :local
end

  def version_params
    params.require(:version).permit(:date, :description, :s3_key, :etag, :file, :song_id)
  end
end
