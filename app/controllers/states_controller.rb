class StatesController < ApplicationController


  def index
  end

  def show
  	#Just adding logic here for now to test out api and saving to ruby object

  	# 1. assume that user wants to see data at the state level
  	# user would select Connecticut and a date that date would query the database to see if the date entered date exists. If it does view the data. If not access the apis for the data, persist and view it.

    #pass in date or date range
    # date = "2020-10-08".to_date
    # state = State.find_by(query_date: date)
          # logic for 1 date passed in
      # data = client.get("https://data.ct.gov/resource/rf3k-f8fg.json", "$where" => "date='2020-10-29T00:00:00.000'")

    ct_user = CtUser.find_or_create_by(username: "Mark")  

    params[:start_date] = "2020-10-01T00:00:00.000"
    params[:end_date] = "2020-10-07T00:00:00.000"

    # state = State.where("query_date >= :start_date AND query_date <= :end_date",
    #   {start_date: params[:start_date], end_date: params[:end_date]})
    #  binding.pry
    # if state.empty?

    	client = SODA::Client.new({:domain => "https://data.ct.gov/resource/rf3k-f8fg.json"})
     data = client.get("https://data.ct.gov/resource/rf3k-f8fg.json", "$where" => "date between '#{params[:start_date]}' and '#{params[:end_date]}'")
    	i=0

    	while i < data.body.count
        state = State.new(name: "CONNECTICUT")
    		state.query_date = data.body[i].date
  		state.total_tests = data.body[i].covid_19_tests_reported
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
    #end
  end

end
