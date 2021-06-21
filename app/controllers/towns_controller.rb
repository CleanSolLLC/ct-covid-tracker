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

  private
    def check_data
      Town.town_data(params, current_user)
      
      if !!current_user.towns.find{|s| s.query_date >= params[:start_date].to_date && s.query_date <= params[:end_date].to_date}
        redirect_to user_towns_path(current_user)
      else
        flash[:alert] = "No data found for dates input"
        redirect_to new_user_town_path(current_user)
      end
    end   
end


