class VersionSerializer < ActiveModel::Serializer
  attributes :id, :date, :description, :s3_key, :etag, :created_at
  has_one :song
end
