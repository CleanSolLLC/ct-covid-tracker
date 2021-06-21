class EthnicCasesController < ApplicationController

  include EthnicCasesHelper
   
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
      check_data
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

  private
    def check_data
      EthnicCase.ethnic_data(params, current_user)
      
      if !!current_user.ethnic_cases.find{|s| s.query_date >= params[:start_date].to_date && s.query_date <= params[:end_date].to_date}
        redirect_to user_ethnic_cases_path(current_user)
      else
        flash[:alert] = "No data found for dates input"
        redirect_to new_user_ethnic_case_path(current_user)
      end
    end  

end
