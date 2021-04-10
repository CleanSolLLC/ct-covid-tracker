class GenderCasesController < ApplicationController

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
    redirect_to user_age_groups_path(user)
  end

  
  def destroy
    @gender_case = GenderCase.find(params[:id])
    @gender_case.destroy
    redirect_to user_gender_cases_path(current_user)
  end

  private

    def check_date
      if Date.parse(params[:start_date]).friday? || Date.parse(params[:start_date]).saturday?
        flash[:alert] = "Start Date Cannot Be on a Friday or Saturday"
        redirect_to new_user_town_path(current_user)
      end

      if Date.parse(params[:start_date]) >= Date.today || Date.parse(params[:end_date]) >= Date.today
        flash[:alert] = "Start or End Date Cannot Be Today or In The Future"
      end

    end

end
