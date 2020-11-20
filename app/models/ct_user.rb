class CtUser < ApplicationRecord
  has_many :states
  has_many :age_groups
  has_many :counties
  has_many :towns
  
  # has_many :counties, through: :covid_stats
  # has_many :towns, through: :covid_stats
end