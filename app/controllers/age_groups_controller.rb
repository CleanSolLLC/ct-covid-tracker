class AgeGroupsController < ApplicationController

  include AgeGroupsHelper
  
   before_action :authenticate_user!
   before_action :check_date, only: [:create]
   before_action :check_values, only: [:create]

  def index
    @age_groups = current_user.age_groups.order('age_group ASC', 'query_date DESC',)
  end

  def new
    @age_group = AgeGroup.new
  end

  def create
    user = User.find(current_user.id)
    AgeGroup.age_data(params, user)
    redirect_to user_age_groups_path(user)
  end

  
  def show
    @age_group = current_user.age_groups.find(params[:id])
  end

  def destroy
    @age_group = AgeGroup.find(params[:id])
    @age_group.destroy
    redirect_to user_age_groups_path(current_user)
  end  

end
