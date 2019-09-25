class Album < ApplicationRecord
  has_many :songs, dependent: :nullify
  validates :title, uniqueness: true

end
