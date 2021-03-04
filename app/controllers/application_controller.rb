class ApplicationController < ActionController::Base
  before_action :configure_permitted_paremeters, if: :devise_controller?

  private

  def configure_permitted_paremeters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :birth_date])
    devise_parameter_sanitizer.permit(:account_update, keys: [:nickname, :birth_date])
  end
  
end
