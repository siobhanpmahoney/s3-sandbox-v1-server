class VersionSerializer < ActiveModel::Serializer
  attributes :id, :date, :description, :s3_key
  has_one :song
end
