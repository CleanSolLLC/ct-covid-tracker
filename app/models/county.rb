class County < ApplicationRecord
  belongs_to :ct_user
  has_many :towns
  # has_many :covid_stats
  # has_many :users, through: :covid_stats
  # has_many :tests
  # has_many :cases
  # has_many :deaths
  # has_many :hospitalizations 
end
