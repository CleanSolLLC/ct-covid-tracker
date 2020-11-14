class CtUserController < ApplicationController

	#Notes this controller will be replaced by the Devise User model once Devise is implemented. Devise will sign up if necessary, sign in and authenticate. Control will be passed to the home route based on params[:id]  

  def new
  	ct_user = CtUser.create(username: "Mark") 
  end

  def home
  	@ct_user = CtUser.find(params[:id])
  	#@ct_user = CtUser.find(1)
  end

  def show

  end

end
