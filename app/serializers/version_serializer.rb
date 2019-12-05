class VersionSerializer < ActiveModel::Serializer
  attributes :id, :date, :description, :s3_key, :etag, :created_at, :song_id
  has_one :song
end
