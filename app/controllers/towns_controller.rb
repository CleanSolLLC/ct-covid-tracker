class TownsController < ApplicationController
   before_action :authenticate_user!
   before_action :check_date, only: [:create]

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


