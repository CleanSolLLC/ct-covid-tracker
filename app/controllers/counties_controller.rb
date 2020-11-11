class CountiesController < ApplicationController
  def show
  	  	#Just adding logic here for now to test out api and saving to ruby object

  	# 1. assume that user wants to see data at the county level
  	# user would select a county and a date that date would query the database to see if the date entered date exists. If it does view the data. If not access the apis for the data, persist and view it.

  	

  	#*** Logic for Getting State Data that is not persisted ***

  	#number of tests per day by county
  	client = SODA::Client.new({:domain => "https://data.ct.gov/resource/qfkt-uahj.json"})

  	  	# logic for a county and multiple dates passed in
  	  	#data = client.get("https://data.ct.gov/resource/qfkt-uahj.json", "$where" => "county='Hartford' AND date between '2020-10-01T00:00:00.000' and '2020-10-10T00:00:00.000'")

  	# logic for a county and 1 date passed in
  	 data = client.get("https://data.ct.gov/resource/qfkt-uahj.json", "$where" => "county='Hartford' AND date='2020-10-29T00:00:00.000'")

  	
    ct_user = CtUser.find_or_create_by(username: "Mark")

    county = County.find_or_create_by(county:'Hartford')
  	#create a collection of state data totals and shovel in after each interation
  	# a state has_many :covid_totals ????

  # 	i=0

  # 	while i < data.body.count
  #     county = County.find_or_create_by(county:'Hartford')
  # 	  county.name = data.body[i].county
		#   county.query_dates = data.body[i].date
  # 		state.total_cases = data.body[i].number_of_tests
  #       state.confirmed_cases = data.body[i].number_of_positives
  # 		state.hospitalized_cases = data.body[i].negatives
		# state.confirmed_deaths = data.body[i].number_of_indeterminates


  # 	ct_user.states << state 
  # 		i+=1
  # 	end
  #   binding.pry
  # end
  # end
end
