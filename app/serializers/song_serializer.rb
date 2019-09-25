class SongSerializer < ActiveModel::Serializer
  attributes :id, :title
  has_one :album
  has_many :versions




end
