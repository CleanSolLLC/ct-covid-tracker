class StatesController < ApplicationController


  def index
  end

  def show
    @state = State.find_by(id: params[:id])
    #@agegroup = AgeGroup.find_by(query_date: @state.query_date)
  end

  def new
  end

  def create
    ct_user = CtUser.find_by(id: params[:ct_user_id]) 
    State.state_data(params)
    redirect_to ct_user_path(ct_user)
  end
end
  	#Just adding logic here for now to test out api and saving to ruby object

  	# 1. assume that user wants to see data at the state level
  	# user would select Connecticut and a date that date would query the database to see if the date entered date exists. If it does view the data. If not access the apis for the data, persist and view it.

    #pass in date or date range
    # date = "2020-10-08".to_date
    # state = State.find_by(query_date: date)
          # logic for 1 date passed in
      # data = client.get("https://data.ct.gov/resource/rf3k-f8fg.json", "$where" => "date='2020-10-29T00:00:00.000'")

    # ct_user = CtUser.find_or_create_by(username: "Mark")  

    # params[:start_date] = "2020-10-01T00:00:00.000"
    # params[:end_date] = "2020-10-07T00:00:00.000"

    # state = State.where("query_date >= :start_date AND query_date <= :end_date",
    #   {start_date: params[:start_date], end_date: params[:end_date]})
    #  binding.pry
    # if state.empty?


    #end


    #This code will ultimately end up in the AgeGroupCase model but will be called in the State model


  #     client = SODA::Client.new({:domain => "https://data.ct.gov/resource/ypz6-8qyf.json"})
        
     
  #     data = client.get("https://data.ct.gov/resource/ypz6-8qyf.json", "$where" => "dateupdated between'#{params[:start_date]}' and '#{params[:end_date]}'")

  #     while i < data.body.count
  #       age_group = AgeGroup.new
  #       age_group.query_date = data.body[i].dateupdated
  #       age_group.age_group = data.body[i].agegroups
  #       age_group.total_cases = data.body[i].totalcases
  #       age_group.total_case_rate = data.body[i].totalcaserate
  #       age_group.total_deaths = data.body[i].totaldeaths
  #       age_group.save
  #       i+=1
  #     end  
  # end
