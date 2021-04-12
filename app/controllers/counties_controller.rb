class CountiesController < ApplicationController
  
  include CountiesHelper

   before_action :authenticate_user!
   before_action :check_date, only: [:create]
   before_action :check_values, only: [:create]

  def index
    @counties = current_user.counties.order('name ASC', 'query_date DESC',)
  end

  def new
    @county = County.new
  end

  def create
    user = User.find(current_user.id)
    County.county_data(params, user)
    redirect_to user_counties_path(user)
  end

  
  def destroy
    @county = County.find(params[:id])
    @county.destroy
    redirect_to user_counties_path(current_user)
  end


  def destroy_all
    counties = County.all
    counties.delete_all
    redirect_to user_counties_path(current_user)
  end


end


