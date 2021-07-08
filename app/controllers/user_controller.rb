class UserController < ApplicationController

  def destroy
  	@user = User.find(params[:id])
  	@user.destroy
  	redirect_to root_path
  end 
end
