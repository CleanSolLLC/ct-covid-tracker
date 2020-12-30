class Town < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :county
  belongs_to_active_hash :county_lookup, :shortcuts => [:name]
end