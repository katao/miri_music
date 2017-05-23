class Song < ApplicationRecord
  belongs_to :album
  has_and_belongs_to_many :moods, dependent: :destroy
  has_and_belongs_to_many :tempos, dependent: :destroy
end
