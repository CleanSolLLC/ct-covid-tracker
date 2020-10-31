class StatesController < ApplicationController
  def index
  end

  def show
  	#Just adding logic here for now and access through pry

  	# 1. assume that user wants to see state data at the state level
  	# user would select Connecticut and a date that date would query the database to see if that date exists. If it does view the data. If not access the apis for the data and persist it

  	client = SODA::Client.new({:domain => "https://data.ct.gov/resource/rf3k-f8fg.json"})

  	data = client.get("https://data.ct.gov/resource/rf3k-f8fg.json", "$where" => "date='2020-10-29T00:00:00.000'")

  	data.body.each do |d|

  		state = State.find_or_create_by(name: d.state)
  		state.query_date = d.date
		state.total_tests = d.covid_19_pcr_tests_reported
  		state.total_cases = d. totalcases
        state.confirmed_cases = d.confirmedcases
  		state.hospitalized_cases = d.hospitalizedcases
		state.confirmed_deaths = d.confirmeddeaths
  		state.cases_age_0_9 = d.cases_age0_9
		state.cases_age_10_19 = d.cases_age10_19
		state.cases_age_20_29 = d.cases_age20_29
		state.cases_age_30_39 = d.cases_age30_39
		state.cases_age_40_49 = d.cases_age40_49
		state.cases_age_50_59 = d.cases_age50_59
		state.cases_age_60_69 = d.cases_age60_69
		state.cases_age_70_79 = d.cases_age70_79
		state.cases_age_80_older = d.cases_age80_older		
  	end
  	state.save
  end
end
