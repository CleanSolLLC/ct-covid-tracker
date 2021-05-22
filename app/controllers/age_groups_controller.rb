class AgeGroupsController < ApplicationController

   include AgeGroupsHelper
   
   before_action :authenticate_user!
   before_action :date_error?, only: [:create]
   before_action :age_group_error?, only: [:create]

  def index
    @age_groups = current_user.age_groups.order('age_group ASC', 'query_date DESC',)
  end

  def new
    @age_group = AgeGroup.new
  end

  def create
    if date_error? || age_group_error?
      redirect_to new_user_age_group_path(current_user)
    else
      user = User.find(current_user.id)
      AgeGroup.age_data(params, user)
      redirect_to user_age_groups_path(user)
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
