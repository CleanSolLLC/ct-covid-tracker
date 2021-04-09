class StatesController < ApplicationController
   include StatesHelper
   
   before_action :authenticate_user!
   before_action :check_date, only: [:create]

 def summary
   @daily_summary = State.daily_summary
   @vaccine_summary = State.vaccine_summary
 end

  def index
    @states = current_user.states.order('query_date DESC')
  end

  def new
    @state = State.new
  end

  def create
    user = User.find(current_user.id)
    State.state_data(params, user)
    redirect_to user_states_path(user)
  end


  def destroy
    @state = State.find(params[:id])
    @state.destroy
    redirect_to user_states_path(current_user)
  end

end
