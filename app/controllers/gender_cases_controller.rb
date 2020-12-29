class GenderCasesController < ApplicationController

  before_action :authenticate_user!

  
  def index
    @gender_cases = current_user.gender_cases.order('query_date DESC')
  end


  def create

  end

  
  def show

  end
end
