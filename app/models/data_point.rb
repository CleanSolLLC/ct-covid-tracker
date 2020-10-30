class DataPoint < ApplicationRecord
  belongs_to :user
  belongs_to :covid_stat
end
