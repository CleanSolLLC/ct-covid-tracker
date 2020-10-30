class CovidStat < ApplicationRecord
  belongs_to :data_point
  belongs_to :state
  belongs_to :county
  belongs_to :town
end
