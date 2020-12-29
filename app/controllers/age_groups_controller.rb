class AgeGroupsController < ApplicationController
  
  before_action :authenticate_user!

  
  def index
    @age_groups = current_user.age_groups.order('query_date DESC', 'age_group DESC')
  end


  def create

  end

  
  def show

  end
end
