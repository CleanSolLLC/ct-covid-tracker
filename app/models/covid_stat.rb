class CovidStat < ApplicationRecord
  belongs_to :ct_user
  belongs_to :state

end
