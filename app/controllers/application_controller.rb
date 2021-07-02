class ApplicationController < ActionController::Base
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include ApplicationHelper

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  after_action :date_error?, only: [:create]
  

  private

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    end

    def record_not_found
      flash[:error] = "Record already deleted."
      redirect_back(fallback_location: root_path)
    end

    def check_data
  
      model_method = "#{controller_name.singularize}" << "_data"
      success_redirect_path = "user_" +  "#{controller_name}" + "_path"
      error_redirect_path = "new_user_" +  "#{controller_name.singularize}" + "_path"

      #call to Class.method
      controller_name.classify.constantize.send(model_method, params, current_user)
    
      
      if !!current_user.send(controller_name).find{|s| s.query_date >= params[:start_date].to_date && s.query_date <= params[:end_date].to_date}
        redirect_to :action => "index", id: current_user.id
      else
        flash[:alert] = "No data found for dates input"
        redirect_to :action => "new", id: current_user.id
      end
    end     

end
