class State < ApplicationRecord
  belongs_to :ct_user

  # validates_date :start_date
  # validates_date :end_date 

  # has_many :gender_cases

  # has_many :gender_datum, through: gender_cases
  # has_many :ethnic_datum, through: ethnic_cases
  # has_many :age_group_datum, through: age_group_cases


  def self.state_data(params)

  	ct_user = CtUser.find_or_create_by(id: params[:ct_user_id])
  	
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
      ct_user.states << state 
      i+=1
    end
  end

end






