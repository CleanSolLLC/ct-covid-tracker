class AgeGroupCase < ApplicationRecord
  belongs_to :state
  belongs_to :age_group_data
end
