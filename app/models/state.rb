class State < ApplicationRecord
  has_many :tests
  has_many :cases
  has_many :deaths
  has_many :hospitalizations 
  # has_many :gender_cases

  # has_many :gender_datum, through: gender_cases
  # has_many :ethnic_datum, through: ethnic_cases
  # has_many :age_group_datum, through: age_group_cases
end

