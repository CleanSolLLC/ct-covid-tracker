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
    #@user = User.find(current_user.id)
    @state = State.new
  end

  def create
    user = User.find(current_user.id)

    State.find_state_data(params, user)
    # EthnicCase.get_ethnic_data(params, user)
    # AgeGroup.age_data(params, user)
    # GenderCase.gender_data(params, user)
    #County.county_data(params, user)
    binding.pry
    redirect_to user_states_path(user)
  end

  
  def show
    @state = current_user.states.find(params[:id])
  end

  private

    def check_date
      if Date.parse(params[:start_date]).friday? || Date.parse(params[:start_date]).saturday?
        flash[:alert] = "Start Date Cannot Be on a Friday or Saturday"
        redirect_to new_user_state_path(current_user)
      end

      if Date.parse(params[:start_date]) >= Date.today || Date.parse(params[:end_date]) >= Date.today
        flash[:alert] = "Start or End Date Cannot Be Today or In The Future"
      end

    end

end
