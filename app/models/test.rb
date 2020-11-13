class Test < ApplicationRecord
  belongs_to :state
  belongs_to :county
  belongs_to :town
end
