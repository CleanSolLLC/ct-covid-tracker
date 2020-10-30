class Town < ApplicationRecord
  belongs_to :county
  has_many :tests
  has_many :cases
  has_many :deaths  
end
