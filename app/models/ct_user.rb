class CtUser < ApplicationRecord
  has_many :covid_stats
  has_many :states, through: :covid_stats
end