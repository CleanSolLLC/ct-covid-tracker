class CtUserController < ApplicationController

  def new
  	ct_user = CtUser.create(username: "Mark") 
  end

  def home
  	@ct_user = CtUser.find(params[:id])
  end

  def show

  end

end
