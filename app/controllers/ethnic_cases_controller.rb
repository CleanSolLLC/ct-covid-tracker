class EthnicCasesController < ApplicationController

  include EthnicCasesHelper
   
   before_action :ethnic_case_error?, only: [:create]

  def index
    @ethnic_cases = current_user.ethnic_cases.order('ethnic_group ASC', 'query_date DESC')

    ethnic_cases_values = @ethnic_cases.pluck(:ethnic_group).uniq
    @ethnic_case_chart = all_ethnic_case_values.map do |ethnic_group|
      {name: ethnic_group, data: EthnicCase.where(ethnic_group: ethnic_group, user_id: current_user.id).group_by_day(:query_date, series: false).sum(:case_change)}
     end 

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
  
end
