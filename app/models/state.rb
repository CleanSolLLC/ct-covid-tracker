class State < ApplicationRecord
  has_many :tests
  has_many :cases
  has_many :deaths
  has_many :hospitalizations 

  has_many :gender_data, through: gender_cases
  has_many :ethnic_data, through: ethnic_cases
  has_many :age_group_data, through: age_group_cases
end

