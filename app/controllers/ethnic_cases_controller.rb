class EthnicCasesController < ApplicationController
   before_action :authenticate_user!
   before_action :check_date, only: [:create]


  def index
    @ethnic_cases = current_user.ethnic_cases.order('query_date DESC')
  end


  def create
    user = User.find(current_user.id)
  
    EthnicCase.get_ethnic_data(params, user)
    redirect_to user_ethnic_cases_path(user)
  end

  
  def show

  end


end
