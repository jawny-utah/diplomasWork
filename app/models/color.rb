class Color < ApplicationRecord
  has_many :wears
  validates :title, uniqueness: true
end
