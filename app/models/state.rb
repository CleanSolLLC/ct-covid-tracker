class State < ApplicationRecord
  belongs_to :user

  # validates_date :start_date
  # validates_date :end_date 

  # has_many :gender_cases

  # has_many :gender_datum, through: gender_cases
  # has_many :ethnic_datum, through: ethnic_cases
  # has_many :age_group_datum, through: age_group_cases


  def self.state_data(params, user)
  	
  	client = SODA::Client.new({:domain => "https://data.ct.gov/resource/rf3k-f8fg.json"})
     data = client.get("https://data.ct.gov/resource/rf3k-f8fg.json", "$where" => "date between '#{params[:start_date]}' and '#{params[:end_date]}'")
   	i=0

   	while i < data.body.count

      state = State.find_or_create_by(query_date: data.body[i].date) 
      #state = State.new(name: "CONNECTICUT")
      state.query_date = data.body[i].date
  	  state.total_tests = data.body[i].covid_19_tests_reported
      state.total_cases = data.body[i].totalcases
      state.confirmed_cases = data.body[i].confirmedcases
      state.hospitalized_cases = data.body[i].hospitalizedcases
  	  state.confirmed_deaths = data.body[i].confirmeddeaths

      #call method to compare previous data
      state = compare(state)
      binding.pry
      user.states << state
      i+=1
    end

    #Then you will want to comapre the data based on dates to determine the attributes listed below

      # measure
      # total
      # changedirection
      # change
      # dateupdated  

  end

  def self.compare(state)

    prev_day = state if prev_day.nil?

    # if prev_day.nil?
    #    prev_day.total_tests = 0
    #    prev_day.total_cases = 0
    #    prev_day.hospitalized_cases = 0
    #    prev_day.confirmed_deaths = 0
    # end


    curr_day = state

    state.test_change = curr_day.total_tests - prev_day.total_tests
    curr_day.test_change.positive? ? state.test_dir = "+" : state.test_dir = "-"

    state.case_change = curr_day.total_cases - prev_day.total_cases
    curr_day.case_change.positive? ? state.case_dir = "+" : state.case_dir = "-"

    state.hospitalized_change = curr_day.hospitalized_cases - prev_day.hospitalized_cases
    curr_day.hospitalized_change.positive? ? state.hosp_dir = "+" : state.hosp_dir = "-"

    state.death_change = curr_day.confirmed_deaths - prev_day.confirmed_deaths
    curr_day.death_change.positive? ? state.death_dir = "+" : state.death_dir = "-"

    prev_day = state

    state

  end




  def self.summary
    
    client = SODA::Client.new({:domain => "https://data.ct.gov/resource/ncg4-6gkj.json"})
     data = client.get("https://data.ct.gov/resource/ncg4-6gkj.json?")
     data.body
  end  

end






