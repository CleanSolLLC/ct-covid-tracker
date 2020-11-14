class State < ApplicationRecord
  has_many :user_states
  has_many :users, through: :user_states
  has_many :age_groups

end
  # has_many :gender_cases

  # has_many :gender_datum, through: gender_cases
  # has_many :ethnic_datum, through: ethnic_cases
  # has_many :age_group_datum, through: age_group_cases

