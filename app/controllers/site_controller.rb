class SiteController < ApplicationController

  before_action :authenticate_user!
 
  def welcome
  end

  def logout
  end
end