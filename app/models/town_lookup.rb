class TownLookup < ActiveHash::Base
	include ActiveHash::Associations
	belongs_to :county_lookup
end