class TownsController < ApplicationController

  include TownsHelper
  
   before_action :town_error?, only: [:create]

  def index
    @towns = current_user.towns.order('name ASC', 'query_date DESC',)
  end

  def new
    @town = Town.new
  end

  def create
    if date_error? || town_error?
      redirect_to new_user_town_path(current_user)
    else
      check_data
    end
  end

  def destroy
    @town = Town.find(params[:id])
    @town.destroy
    redirect_to user_towns_path(current_user)
  end

  def destroy_all
    towns = Town.all
    towns.delete_all
    redirect_to user_towns_path(current_user)
  end
   
end


