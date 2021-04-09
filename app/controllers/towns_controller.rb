class TownsController < ApplicationController

  include TownsHelper
  
   before_action :authenticate_user!
   before_action :check_date, only: [:create]
   before_action :check_values, only: [:create]

  def index
    @towns = current_user.towns.order('name ASC', 'query_date DESC',)
  end

  def new
    @town = Town.new
  end

  def create
    user = User.find(current_user.id)
    Town.town_data(params, user)
    redirect_to user_towns_path(user)
  end

  
  def show
    @town = current_user.towns.find(params[:id])
  end

  def destroy
    @town = Town.find(params[:id])
    @town.destroy
    redirect_to user_towns_path(current_user)
  end

end


