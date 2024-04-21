class ApplicationController < ActionController::Base
    before_action :configure_sanitized_params, if: :devise_controller?
    
    def configure_sanitized_params
      devise_parameter_sanitizer.permit(:sign_up) do |user_params|
        user_params.permit(:email, :password, :password_confirmation, customer_attributes: [:name, :phone])
      end
    end
  end
  