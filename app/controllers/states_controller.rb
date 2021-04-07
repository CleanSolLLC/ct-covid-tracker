class StatesController < ApplicationController
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

  private


    def check_date

      if !params[:start_date].present? || !params[:end_date].present?
        flash[:alert] = "Start Date or End Date Cannot Be Blank"
        redirect_to new_user_state_path(current_user)

    
      elsif Date.parse(params[:start_date]).friday? || Date.parse(params[:start_date]).saturday?
        flash[:alert] = "Start Date Cannot Be on a Friday or Saturday"
        redirect_to new_user_state_path(current_user)
      

      elsif Date.parse(params[:start_date]) >= Date.today || Date.parse(params[:end_date]) >= Date.today
        flash[:alert] = "Start or End Date Cannot Be Today or In The Future"
        redirect_to new_user_state_path(current_user)      
      end

    end

end
