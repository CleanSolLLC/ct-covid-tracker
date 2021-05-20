class ApplicationController < ActionController::Base

  include ApplicationHelper

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!


  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end

  def record_not_found
    #flash[:error] = "Record already deleted."
      redirect_back(fallback_location: root_path)
  end

  # Overriding the sign_out redirect path method
  # def after_sign_out_path_for(resource_or_scope)
  #   logged_out_path
  # end

end
