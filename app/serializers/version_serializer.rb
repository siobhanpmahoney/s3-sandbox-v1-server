class VersionSerializer < ActiveModel::Serializer
  attributes :id, :date, :description, :s3_key, :etag
  has_one :song
end
