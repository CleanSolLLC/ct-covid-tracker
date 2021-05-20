class EthnicCasesController < ApplicationController

  include EthnicCasesHelper
   
   before_action :authenticate_user!
   before_action :date_error?, only: [:create]
   before_action :ethnic_case_error?, only: [:create]

  def index
    @ethnic_cases = current_user.ethnic_cases.order('ethnic_group ASC', 'query_date DESC',)
  end

  def new
    @ethnic_case = EthnicCase.new
  end

  def create
    if date_error? || ethnic_case_error?
      redirect_to new_user_ethnic_case_path(current_user)
    else  
      user = User.find(current_user.id)
      EthnicCase.ethnic_data(params, user)
      redirect_to user_ethnic_cases_path(user)
    end
  end

  
  def destroy
    @ethnic_case = EthnicCase.find(params[:id])
    @ethnic_case.destroy
    redirect_to user_ethnic_cases_path(current_user)
  end

  def destroy_all
    ethnic_cases = EthnicCase.all
    ethnic_cases.delete_all
    redirect_to user_ethnic_cases_path(current_user)
  end  

end
