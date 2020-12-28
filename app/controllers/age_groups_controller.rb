class AgeGroupsController < ApplicationController
  
  def index
    @age_groups = current_user.age_groups.order('query_date DESC')
  end


  def create

  end

  
  def show

  end
end
