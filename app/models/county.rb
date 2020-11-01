class County < ApplicationRecord
  has_many :towns
  # has_many :tests
  # has_many :cases
  # has_many :deaths
  # has_many :hospitalizations 
end
