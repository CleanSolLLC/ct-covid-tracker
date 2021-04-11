class EthnicCasesController < ApplicationController

  include EthnicCasesHelper
   
   before_action :authenticate_user!
   before_action :check_date, only: [:create]
   before_action :check_values, only: [:create]

  def index
    @ethnic_cases = current_user.ethnic_cases.order('ethnic_group ASC', 'query_date DESC',)
  end

  def new
    @ethnic_case = EthnicCase.new
  end

  def create
    user = User.find(current_user.id)
    EthnicCase.ethnic_data(params, user)
    redirect_to user_ethnic_cases_path(user)
  end

  
  def destroy
    @ethnic_case = EthnicCase.find(params[:id])
    @ethnic_case.destroy
    redirect_to user_ethnic_cases_path(current_user)
  end

end
