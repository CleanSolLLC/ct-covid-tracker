class GenderCasesController < ApplicationController

  include GenderCasesHelper

   before_action :authenticate_user!
   before_action :check_date, only: [:create]

  def index
    @gender_cases = current_user.gender_cases.order('query_date DESC','gender ASC')
  end

  def new
    @gender_case = GenderCase.new
  end

  def create
    user = User.find(current_user.id)
    GenderCase.gender_data(params, user)
    redirect_to user_gender_cases_path(user)
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
