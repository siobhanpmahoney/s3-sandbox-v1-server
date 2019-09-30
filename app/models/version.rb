class Version < ApplicationRecord
  belongs_to :song
  validates :s3_key, presence: true, uniqueness: true
  has_one_attached :file
end
