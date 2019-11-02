require 'aws-sdk-s3'


class Api::V1::S3Controller < ApplicationController


  def list_objects
    s3 = Aws::S3::Client.new({profile: {aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'], aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']}, region: 'us-east-1'})
    # s3.list_objects_v2(bucket: 'sandbox-v3')

    resp = s3.list_objects_v2(bucket: 'sandbox-v3')
    contents = {}
    resp.contents.each do |obj|
      contents[obj.key] = obj
    end
    render json: contents, status: 201
  end

  def signed_url # working method for getting presigned url
    signer = Aws::S3::Presigner.new
    url = signer.presigned_url(:get_object, bucket: "sandbox-v3", key: params["key"], expires_in: 3600)
    render json: {url: url}

    # puts "params"
    # puts params
    # client = Aws::S3::Client.new({profile: {aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'], aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']}, region: 'us-east-1'})
    # obj = client.get_object({
    #   bucket:'sandbox-v3',
    #   key: "Oct012019/album1.v2/song1.v2/10032019.m4a"
    #   # key: params[:key]
    # })
    #
    # render json: {presigned_url: obj.presigned_url(:get, expires_in: 3600)}

    # Aws.config[:s3] = {region: 'us-east-1', credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY']),retry_limit: 10 }

    # presigner = Aws::S3::Presigner.new(client: Aws::S3::Client.new)

    # s3_params = {
    #   bucket: params[:bucket],
    #   key: params[:key],
    #   expires_in: 86400
    # }
    # resp = presigner.presigned_url(:get_object, s3_params)
    # render resp
  end


  # attempt 1
  def direct_post


    aws_credentials = Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY'])
    s3_bucket = Aws::S3::Resource.new(region: 'us-east-1', credentials: aws_credentials).bucket(ENV['S3_BUCKET']) ### 's3_bucket' = actual bucket
    presigned_url = s3_bucket.presigned_post(key: "#{Rails.env}/#{SecureRandom.uuid}/#{params[:filename]}", success_action_status: '201', signature_expiration: (Time.now.utc + 15.minutes))
    data = { url: presigned_url.url, url_fields: presigned_url.fields }
    render json: data, status: :ok


  end

  private

  def s3_params
    params.require(:s3).permit(:bucket, :key)
  end
end
