class CtUser < ApplicationRecord
  has_many :covid_stats
  has_many :states, through: :covid_stats
  # has_many :counties, through: :covid_stats
  # has_many :towns, through: :covid_stats
end