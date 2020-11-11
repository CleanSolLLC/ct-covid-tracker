class County < ApplicationRecord
  has_many :towns
  # has_many :covid_stats
  # has_many :users, through: :covid_stats
  # has_many :tests
  # has_many :cases
  # has_many :deaths
  # has_many :hospitalizations 
end
