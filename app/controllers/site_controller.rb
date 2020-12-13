class SiteController < ApplicationController

  before_action :authenticate_user!
 
  def welcome
  	@user = User.find(current_user.id)
  end

  def logout
  end
end