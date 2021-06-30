class State < ApplicationRecord
  extend GetData
  
  belongs_to :user

  def self.state_data(params, user)

    prev_date = get_prev_date(params[:start_date])
    end_date = params[:end_date]
  	
  	client = SODA::Client.new({:domain => "https://data.ct.gov/resource/rf3k-f8fg.json"})
  
    data = client.get("https://data.ct.gov/resource/rf3k-f8fg.json", "$where" => "date between '#{prev_date}' and '#{end_date}'")

   data = find_state_data(params[:start_date], data) 
   #sorted_data = data_found.sort_by{|hsh| hsh[:date]}

    data.each_index do |i| 

      return if data[i+1].nil? 

      state = State.find_or_initialize_by(user_id: user.id, query_date: data[i+1][:date])    

      if state.id.nil?

        state.query_date = data[i+1].date 
        state.total_tests = data[i+1].covid_19_tests_reported.to_i
        state.total_cases = data[i+1].totalcases.to_i
        state.confirmed_cases = data[i+1].confirmedcases.to_i
        state.hospitalized_cases = data[i+1].hospitalizedcases.to_i
        state.confirmed_deaths = data[i+1].confirmeddeaths.to_i
        state.test_change = (data[i+1].covid_19_tests_reported.to_i - data[i].covid_19_tests_reported.to_i).abs
        (data[i+1].covid_19_tests_reported.to_i > data[i].covid_19_tests_reported.to_i) ? state.test_dir = "+" : state.test_dir = "-" unless state.test_change == 0
        state.case_change = (data[i+1].totalcases.to_i - data[i].totalcases.to_i).abs
        (data[i+1].totalcases.to_i > data[i].totalcases.to_i) ? state.case_dir = "+" : state.case_dir = "-" unless state.case_change == 0
        state.hospitalized_change = (data[i+1].hospitalizedcases.to_i - data[i].hospitalizedcases.to_i).abs
        (data[i+1].hospitalizedcases.to_i > data[i].hospitalizedcases.to_i) ? state.hosp_dir = "+" : state.hosp_dir = "-" unless state.hospitalized_change == 0
        state.death_change = (data[i+1].confirmeddeaths.to_i - data[i].confirmeddeaths.to_i).abs
        (data[i+1].confirmeddeaths.to_i > data[i].confirmeddeaths.to_i) ? state.death_dir = "+" : state.death_dir = "-" unless state.death_change == 0

        user.states << state
      end
    end

  end



  def self.daily_summary
    #this logic creates a snapshot of statewide statistics from the prev day on a summary page 

    client = SODA::Client.new({:domain => "https://data.ct.gov/resource/ncg4-6gkj.json"})
     data = client.get("https://data.ct.gov/resource/ncg4-6gkj.json?")
     data
  end 
  
  def self.vaccine_summary
    #this logic creates a snapshot of vaccine data for summary page

    client = SODA::Client.new({:domain => "https://data.ct.gov/resource/tttv-egb7.json"})
     data.body = client.get("https://data.ct.gov/resource/tttv-egb7.json")
     data.find{|d| d[:category] == "Total"}
  end 


end






