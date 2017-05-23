class Tempo < ApplicationRecord
  has_and_belongs_to_many :songs, dependent: :destroy
end
