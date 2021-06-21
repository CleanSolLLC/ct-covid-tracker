class State < ApplicationRecord
  
  belongs_to :user

  #1. we need to find the prev date to grab totals that will be used to compare to current date
  #2. check to see if date falls on a Sunday
  #3. if it does we need the data from the Thursday prior to comapre with Sunday's data

  # **** CHECK TO SEE IF DATA QUERIED IS PERSISTED IN DB. IF SO THERE IS NO NEED TO CALL API ******

  # **** STATE_DATA SHLOULD ONLY BE CALLED IF DATA DOES NOT EXIST IN THE DB ******

  # **** THIS LOGIC WILL ALSO APPLY TO THE OTHER MODELS COUNTY, TOWN, GENDER_CASE, ETHNIC_CASEE, AGE_GROUP ******



  def self.state_data(params, user)


    if Date.parse(params[:start_date]).sunday?
      prev_date = (Date.parse(params[:start_date]).prev_day-2).to_s
    else
      prev_date = (Date.parse(params[:start_date]).prev_day).to_s
    end

    end_date = params[:end_date]
  	
  	client = SODA::Client.new({:domain => "https://data.ct.gov/resource/rf3k-f8fg.json"})
  
    data = client.get("https://data.ct.gov/resource/rf3k-f8fg.json", "$where" => "date between '#{prev_date}' and '#{end_date}'")

    data.body.each_index do |i| 

      return if data.body[i+1].nil? 

      state = State.find_or_initialize_by(user_id: user.id, query_date: data.body[i+1][:date])    

      if state.id.nil?

        state.query_date = data.body[i+1].date 
        state.total_tests = data.body[i+1].covid_19_tests_reported.to_i
        state.total_cases = data.body[i+1].totalcases.to_i
        state.confirmed_cases = data.body[i+1].confirmedcases.to_i
        state.hospitalized_cases = data.body[i+1].hospitalizedcases.to_i
        state.confirmed_deaths = data.body[i+1].confirmeddeaths.to_i
        state.test_change = (data.body[i+1].covid_19_tests_reported.to_i - data.body[i].covid_19_tests_reported.to_i).abs
        (data.body[i+1].covid_19_tests_reported.to_i > data.body[i].covid_19_tests_reported.to_i) ? state.test_dir = "+" : state.test_dir = "-" unless state.test_change == 0
        state.case_change = (data.body[i+1].totalcases.to_i - data.body[i].totalcases.to_i).abs
        (data.body[i+1].totalcases.to_i > data.body[i].totalcases.to_i) ? state.case_dir = "+" : state.case_dir = "-" unless state.case_change == 0
        state.hospitalized_change = (data.body[i+1].hospitalizedcases.to_i - data.body[i].hospitalizedcases.to_i).abs
        (data.body[i+1].hospitalizedcases.to_i > data.body[i].hospitalizedcases.to_i) ? state.hosp_dir = "+" : state.hosp_dir = "-" unless state.hospitalized_change == 0
        state.death_change = (data.body[i+1].confirmeddeaths.to_i - data.body[i].confirmeddeaths.to_i).abs
        (data.body[i+1].confirmeddeaths.to_i > data.body[i].confirmeddeaths.to_i) ? state.death_dir = "+" : state.death_dir = "-" unless state.death_change == 0

        user.states << state
      end
    end

  end



  def self.daily_summary
    #this logic creates a snapshot of statewide statistics from the prev day on a summary page 

    client = SODA::Client.new({:domain => "https://data.ct.gov/resource/ncg4-6gkj.json"})
     data = client.get("https://data.ct.gov/resource/ncg4-6gkj.json?")
     data.body
  end 
  
  def self.vaccine_summary
    #this logic creates a snapshot of vaccine data for summary page

    client = SODA::Client.new({:domain => "https://data.ct.gov/resource/tttv-egb7.json"})
     data = client.get("https://data.ct.gov/resource/tttv-egb7.json")
     data.body.find{|d| d[:category] == "Total"}
  end 


end






