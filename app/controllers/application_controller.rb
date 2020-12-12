class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end

  # Overriding the sign_out redirect path method
  # def after_sign_out_path_for(resource_or_scope)
  #   logged_out_path
  # end

end
