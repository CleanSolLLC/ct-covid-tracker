class AgeGroupsController < ApplicationController

   include AgeGroupsHelper

   before_action :age_group_error?, only: [:create]

  def index
    @age_groups = current_user.age_groups.order('age_group ASC', 'query_date DESC')
    all_age_group_values = AgeGroup.all.pluck(:age_group).uniq
    @age_groups_chart = all_age_group_values.map do |age_group|
      {name: age_group, data: AgeGroup.where(age_group: age_group, user_id: current_user.id).group_by_day(:query_date, series: false).sum(:confirmed_cases)}
     end 
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
  
end
