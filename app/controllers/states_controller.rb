class StatesController < ApplicationController
   before_action :authenticate_user!
   before_action :check_date, only: [:create]

 def summary
   @summary = State.summary
 end

  def index
    @states = current_user.states.order('query_date DESC')
  end

  def new
    @user = User.find(current_user.id)
  end

  def create
    user = User.find(current_user.id)
  
    State.state_data(params, user)
    #AgeGroup.age_data(params)
    redirect_to user_states_path(user)
    binding.pry
  end

  
  def show
    @state = current_user.states.find(params[:id])
  end

  private

    def check_date
      if Date.parse(params[:start_date]).friday? || Date.parse(params[:start_date]).saturday?
        flash[:alert] = "Begin Date Cannot Be on a Friday or Saturday"
        redirect_to new_user_state_path(current_user)
      end
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



        
     
 
  # end
