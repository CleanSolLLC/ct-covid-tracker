class CtUser < ApplicationRecord
  has_many :user_states
  has_many :states, through: :user_states
  # has_many :counties, through: :covid_stats
  # has_many :towns, through: :covid_stats
end