class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :nickname])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :nickname])
  end

  # def current_user
  #return unless session[:user_id]
  #@current_user ||= User.find(session[:user_id])
  #end

  def after_sign_in_path_for(_resource)
    new_chat_path
  end

end
