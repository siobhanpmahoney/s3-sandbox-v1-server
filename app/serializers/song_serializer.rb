class SongSerializer < ActiveModel::Serializer
  attributes :id, :title, :album_id
  # has_one :album
  has_many :versions




end
