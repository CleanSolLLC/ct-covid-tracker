class State < ApplicationRecord
  has_many :covid_stats
  has_many :users, through: :covid_stats

end
  # has_many :gender_cases

  # has_many :gender_datum, through: gender_cases
  # has_many :ethnic_datum, through: ethnic_cases
  # has_many :age_group_datum, through: age_group_cases

