class AlbumSerializer < ActiveModel::Serializer
  attributes :id, :title, :s3_key, :etag
  has_many :songs




end
