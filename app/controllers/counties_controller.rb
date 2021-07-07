class CountiesController < ApplicationController

   include CountiesHelper

   before_action :county_error?, only: [:create]

  def index
    @counties = current_user.counties.order('name ASC', 'query_date DESC')

    all_county_values = @counties.pluck(:name).uniq
    @counties_chart = all_county_values.map do |county|
      {name: county, data: County.where(name: county, user_id: current_user.id).group_by_day(:query_date, series: false).sum(:case_change)}
     end 

  end

  def new
    @county = County.new
  end

  def create
    if date_error? || county_error?
      redirect_to new_user_county_path(current_user)
    else
      check_data
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


