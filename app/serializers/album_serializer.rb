class AlbumSerializer < ActiveModel::Serializer
  attributes :id, :title, :image
  has_many :songs




end