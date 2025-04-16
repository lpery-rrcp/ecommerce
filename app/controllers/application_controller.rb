class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  allow_browser versions: :modern
  before_action :authenticate_user!
  helper :breadcrumbs

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path # This redirects to the login page
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :address, :city, :province_id ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :address, :city, :province_id ])
  end
end
