class Song < ApplicationRecord
  belongs_to :album, optional: true
  has_many :versions
  validates :title, presence: true, uniqueness: false
  validates :album_id, presence: false
end
