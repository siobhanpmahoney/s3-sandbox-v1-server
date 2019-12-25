class AlbumSerializer < ActiveModel::Serializer
  attributes :id, :title, :image, :s3_key, :etag
  has_many :songs




end
