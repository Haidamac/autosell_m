class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ArgumentError, with: :invalid_argument

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name phone])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name phone])
  end

  def record_not_found
    redirect_to root_path, alert: 'record not found'
  end

  def invalid_argument
    redirect_to root_path, alert: 'invalid argument'
  end
end
