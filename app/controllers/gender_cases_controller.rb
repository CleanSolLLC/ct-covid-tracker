class GenderCasesController < ApplicationController

  def index
    @gender_cases = current_user.gender_cases.order('query_date DESC','gender ASC')
  end

  def new
    @gender_case = GenderCase.new
  end

  def create
    if date_error?
      redirect_to new_user_gender_case_path(current_user)
    else
      check_data
    end
  end

  
  def destroy
    @gender_case = GenderCase.find(params[:id])
    @gender_case.destroy
    redirect_to user_gender_cases_path(current_user)
  end


  def destroy_all
    gender_cases = GenderCase.all
    gender_cases.delete_all
    redirect_to user_gender_cases_path(current_user)
  end
end
