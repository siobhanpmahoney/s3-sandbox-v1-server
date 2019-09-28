require 'aws-sdk-s3'


class Api::V1::S3Controller < ApplicationController

  def signed_url
    Aws.config[:s3] = {region: 'us-east-1', credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY']),retry_limit: 10 }

    presigner = Aws::S3::Presigner.new(client: Aws::S3::Client.new)

    params = {
      # bucket: params[:bucket],
      # key: params[:key],
      expires_in: 86400
    }
    presigner.presigned_url(:get_object, params)
  end


  # attempt 1
  def direct_post

    aws_credentials = Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY'])
    s3_bucket = Aws::S3::Resource.new(region: 'us-east-1', credentials: aws_credentials).bucket(ENV['S3_BUCKET']) ### 's3_bucket' = actual bucket
    presigned_url = s3_bucket.presigned_post(key: "#{Rails.env}/#{SecureRandom.uuid}/${filename}", success_action_status: '201', signature_expiration: (Time.now.utc + 15.minutes))
    data = { url: presigned_url.url, url_fields: presigned_url.fields }
    render json: data, status: :ok


  end

  private

  def s3_params
  end
end
