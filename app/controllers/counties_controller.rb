class CountiesController < ApplicationController
  def show
  	  	#Just adding logic here for now to test out api and saving to ruby object

  	# 1. assume that user wants to see data at the county level
  	# user would select a county and a date that date would query the database to see if the date entered date exists. If it does view the data. If not access the apis for the data, persist and view it.

  	

  	#*** Logic for Getting State Data that is not persisted ***

  	#number of tests per day by county
  	client = SODA::Client.new({:domain => "https://data.ct.gov/resource/qfkt-uahj.json"})

  	  	# logic for multiple dates passed in
  	  	#data = client.get("https://data.ct.gov/resource/qfkt-uahj.json", "$where" => "date between '2020-10-01T00:00:00.000' and '2020-10-10T00:00:00.000'")

  	# logic for 1 date passed in
  	  data = client.get("https://data.ct.gov/resource/qfkt-uahj.json", "$where" => "date='2020-10-29T00:00:00.000'")

  	
    ct_user = CtUser.find_or_create_by(username: "Mark")

    #state = State.new
  	#create a collection of state data totals and shovel in after each interation
  	# a state has_many :covid_totals ????

  	i=0

  	while i < data.body.count
      state = State.new(name: "CONNECTICUT")
  		state.query_date = data.body[i].date
		state.total_tests = data.body[i].covid_19_pcr_tests_reported
  		state.total_cases = data.body[i].totalcases
        state.confirmed_cases = data.body[i].confirmedcases
  		state.hospitalized_cases = data.body[i].hospitalizedcases
		state.confirmed_deaths = data.body[i].confirmeddeaths
  		state.cases_age_0_9 = data.body[i].cases_age0_9
		state.cases_age_10_19 = data.body[i].cases_age10_19
		state.cases_age_20_29 = data.body[i].cases_age20_29
		state.cases_age_30_39 = data.body[i].cases_age30_39
		state.cases_age_40_49 = data.body[i].cases_age40_49
		state.cases_age_50_59 = data.body[i].cases_age50_59
		state.cases_age_60_69 = data.body[i].cases_age60_69
		state.cases_age_70_79 = data.body[i].cases_age70_79
		state.cases_age_80_older = data.body[i].cases_age80_older	
  	ct_user.states << state 
  		i+=1
  	end
    binding.pry
  end
  end
end
