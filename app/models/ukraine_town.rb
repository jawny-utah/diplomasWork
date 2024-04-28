class UkraineTown < ApplicationRecord
  validates :name, uniqueness: true
end
