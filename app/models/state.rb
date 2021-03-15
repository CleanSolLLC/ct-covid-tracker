class State < ApplicationRecord
  
  belongs_to :user
  has_many :counties
  has_many :towns, through: :counties
  has_many :ethnic_cases
  has_one :county_lookup

  accepts_nested_attributes_for :county_lookup


  #1. we need to find the prev date to grab totals that will be used to compare to current date
  #2. check to see if date falls on a Sunday
  #3. if it does we need the data from the Thursday prior to comapre with Sunday's data

  # **** CHECK TO SEE IF DATA QUERIED IS PERSISTED IN DB. IF SO THERE IS NO NEED CALL API ******

  # **** STATE_DATA SHLOULD ONLY BE CALLED IF DATA DOES NOT EXIST IN THE DB ******

  # **** THIS LOGIXC WILL ALSO APPLY TO THE OTHER MODELS COUNTY, TOWN, GENDER_CASE, ETHNIC_CASEE, AGE_GROUP ******



  def self.state_data(params, user)

    if Date.parse(params[:start_date]).sunday?
      start_date = (Date.parse(params[:start_date]).prev_day-2).to_s
    else
      start_date = (Date.parse(params[:start_date]).prev_day).to_s
    end

    end_date = params[:end_date]

  	
  	client = SODA::Client.new({:domain => "https://data.ct.gov/resource/rf3k-f8fg.json"})
  
    data = client.get("https://data.ct.gov/resource/rf3k-f8fg.json", "$where" => "date between '#{start_date}' and '#{end_date}'")


    i = 1
    date = params[:start_date]

    while i < data.body.count  

      state = State.find_or_initialize_by(user_id: user.id, query_date: date)

      if state.id.nil? && (!Date.parse(date).friday? || !Date.parse(date).saturday?)

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

        state.cases_age0_9 = data.body[i].cases_age0_9
        state.cases_age10_19 = data.body[i].cases_age10_19
        state.cases_age20_29 = data.body[i].cases_age20_29
        state.cases_age30_39 = data.body[i].cases_age30_39
        state.cases_age40_49 = data.body[i].cases_age40_49
        state.cases_age50_59 = data.body[i].cases_age50_59
        state.cases_age60_69 = data.body[i].cases_age60_69
        state.cases_age70_79 = data.body[i].cases_age70_79
        state.cases_age80_older = data.body[i].cases_age80_older
        
        user.states << state
      end

      date = (Date.parse(date) + 1).to_s
      i+=1
    end

  end


  def self.summary
    
    client = SODA::Client.new({:domain => "https://data.ct.gov/resource/ncg4-6gkj.json"})
     data = client.get("https://data.ct.gov/resource/ncg4-6gkj.json?")
     data.body
  end  

end






