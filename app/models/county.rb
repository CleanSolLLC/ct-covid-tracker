class County < ApplicationRecord
  belongs_to :state
  has_many :towns
end
