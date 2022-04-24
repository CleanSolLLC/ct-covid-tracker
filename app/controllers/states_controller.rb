class StatesController < ApplicationController

 def summary
   @daily_summary = State.daily_summary
   @vaccine_summary = State.vaccine_summary
 end

 def about
 end

  def index
    @states = current_user.states.order('query_date DESC')

    all_state_values = @states.pluck(:name).uniq
    @states_chart = all_state_values.map do |state|
      {name: "Statewide", data: State.where(name: state, user_id: current_user.id).group_by_day(:query_date, series: false).sum(:case_change)}
     end 
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
  
end
