class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :phone])
    end
  

    def after_sign_up_path_for(resource)
      return_to_pg_building = session[:return_to_pg_building]
      root_path # or any other default path if return_to_pg_building is nil

      # Redirect to the stored path if it exists, otherwise redirect to the root path
      redirect_path = return_to_pg_building.present? ? return_to_pg_building : root_path

      # Delete the stored path from the session after redirection
      session.delete(:return_to_pg_building)

      redirect_path
    end
  end
  