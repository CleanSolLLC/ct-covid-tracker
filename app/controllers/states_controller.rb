class StatesController < ApplicationController

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
    if date_error?
      redirect_to new_user_state_path(current_user) 
    else
      check_data
    end
  end


  def destroy
    @state = State.find(params[:id])
    @state.destroy
    redirect_to user_states_path(current_user)
  end

  def destroy_all
    states = State.all
    states.delete_all
    redirect_to user_states_path(current_user)
  end

  private
    def check_data
      State.state_data(params, current_user)
      
      if current_user.states.find{|s| s.query_date >= params[:start_date].to_date && s.query_date <= params[:end_date].to_date}
        redirect_to user_states_path(current_user)
      else
        flash[:alert] = "No data found for dates input"
        redirect_to new_user_state_path(current_user)
      end
    end

end
