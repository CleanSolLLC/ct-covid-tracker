class AgeGroupsController < ApplicationController
  
  def show
  	@age_group = AgeGroup.find_by(id: params[:id])
  end
end
