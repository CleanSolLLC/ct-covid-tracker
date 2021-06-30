class AgeGroupsController < ApplicationController

   include AgeGroupsHelper

   before_action :age_group_error?, only: [:create]

  def index
    @age_groups = current_user.age_groups.order('age_group ASC', 'query_date DESC')
  end

  def new
    @age_group = AgeGroup.new
  end

  def create
    if date_error? || age_group_error?
      redirect_to new_user_age_group_path(current_user)
    else
      check_data
    end
  end
  
  def destroy
    @age_group = AgeGroup.find(params[:id])
    @age_group.destroy
    redirect_to user_age_groups_path(current_user)
  end 


  def destroy_all
    age_groups = AgeGroup.all
    age_groups.delete_all
    redirect_to user_age_groups_path(current_user)
  end

  private
    def check_data
      AgeGroup.age_group_data(params, current_user)
      
      if !!current_user.age_groups.find{|s| s.query_date >= params[:start_date].to_date && s.query_date <= params[:end_date].to_date}
        redirect_to user_age_groups_path(current_user)
      else
        flash[:alert] = "No data found for dates input"
        redirect_to new_user_age_group_path(current_user)
      end
    end  


end
