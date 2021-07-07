class ApplicationController < ActionController::Base
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include ApplicationHelper

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  after_action :date_error?, only: [:create]
  

  private

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    end

    def check_data
  
      model_method = "#{controller_name.singularize}" << "_data"

      #call to specific class.method using values passed in from controller
      controller_name.classify.constantize.send(model_method, params, current_user)
    
      
      if !!current_user.send(controller_name).find{|s| s.query_date >= params[:start_date].to_date && s.query_date <= params[:end_date].to_date}
        redirect_to :action => "index", id: current_user.id
      else
        flash[:alert] = "No data found for dates input"
        redirect_to :action => "new", id: current_user.id
      end
    end     

end
