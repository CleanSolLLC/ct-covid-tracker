class CountiesController < ApplicationController

   include CountiesHelper

   before_action :county_error?, only: [:create]

  def index
    @counties = current_user.counties.order('name ASC', 'query_date DESC',)
  end

  def new
    @county = County.new
  end

  def create
    if date_error? || county_error?
      redirect_to new_user_county_path(current_user)
    else
      user = User.find(current_user.id)
      County.county_data(params, user)
      redirect_to user_counties_path(user)
    end  
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


