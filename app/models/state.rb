class State < ApplicationRecord
  
  belongs_to :user
  has_many :counties
  has_many :towns, through: :counties
  has_many :ethnic_cases


  #1. we need to find the prev date to grab totals that will be used to compare to current date
  #2. check to see if date falls on a Sunday
  #3. if it does we need the data from the Thursday prior to comapre with Sunday's data


  def self.state_data(params, user)

    if Date.parse(params[:start_date]).sunday?
      start_date = (Date.parse(params[:start_date]).prev_day-2).to_s
    else
      start_date = (Date.parse(params[:start_date]).prev_day).to_s
    end

    end_date = params[:end_date]

  	
  	client = SODA::Client.new({:domain => "https://data.ct.gov/resource/rf3k-f8fg.json"})
  
     data = client.get("https://data.ct.gov/resource/rf3k-f8fg.json", "$where" => "date between '#{start_date}' and '#{end_date}'")
   	
    i=1

   	while i < data.body.count

      state = State.find_or_create_by(user_id: user.id, query_date: data.body[i].date) 
      #state = State.new(name: "CONNECTICUT")

        state.query_date = data.body[i].date
    	  state.total_tests = data.body[i].covid_19_tests_reported.to_i
        state.total_cases = data.body[i].totalcases.to_i
        state.confirmed_cases = data.body[i].confirmedcases.to_i
        state.hospitalized_cases = data.body[i].hospitalizedcases.to_i
    	  state.confirmed_deaths = data.body[i].confirmeddeaths.to_i
        state.test_change = (data.body[i].covid_19_tests_reported.to_i - data.body[i-1].covid_19_tests_reported.to_i)
        (data.body[i-1].covid_19_tests_reported.to_i < data.body[i].covid_19_tests_reported.to_i) ? state.test_dir = "+" : state.test_dir = "-"
        state.case_change = (data.body[i].totalcases.to_i - data.body[i-1].totalcases.to_i)
        (data.body[i-1].totalcases.to_i < data.body[i].totalcases.to_i) ? state.case_dir = "+" : state.case_dir = "-"
        state.hospitalized_change = (data.body[i].hospitalizedcases.to_i - data.body[i-1].hospitalizedcases.to_i)
        (data.body[i-1].hospitalizedcases.to_i < data.body[i].hospitalizedcases.to_i) ? state.hosp_dir = "+" : state.hosp_dir = "-"
        state.death_change = (data.body[i].confirmeddeaths.to_i - data.body[i-1].confirmeddeaths.to_i)
        (data.body[i-1].confirmeddeaths.to_i < data.body[i].confirmeddeaths.to_i) ? state.death_dir = "+" : state.death_dir = "-"

        user.states << state
        
      i+=1
    end

  end


  def self.summary
    
    client = SODA::Client.new({:domain => "https://data.ct.gov/resource/ncg4-6gkj.json"})
     data = client.get("https://data.ct.gov/resource/ncg4-6gkj.json?")
     data.body
  end  

end






