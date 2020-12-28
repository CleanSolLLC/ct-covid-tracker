class EthnicCasesController < ApplicationController
   before_action :authenticate_user!
   before_action :check_date, only: [:create]

 def summary
   @summary = State.summary
 end

  def index
    @ethnic_cases = current_user.ethnic_cases.order('query_date DESC')
  end

  def new
    @user = User.find(current_user.id)
  end

  def create
    user = User.find(current_user.id)
  
    EthnicCase.get_ethnic_data(params, user)
    redirect_to user_ethnic_cases_path(user)
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
