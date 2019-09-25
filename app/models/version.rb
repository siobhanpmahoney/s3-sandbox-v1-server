class Version < ApplicationRecord
  belongs_to :song
  validates :s3_key, presence: true, uniqueness: true
end
