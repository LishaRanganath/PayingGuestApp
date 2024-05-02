# frozen_string_literal: true

class User::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected


  def after_sign_in_path_for(resource)
    stored_location = session[:stored_location]

    # Check if there's stored form data
    if stored_location.present? && session[:booking_form_data].present?
      # Redirect to the stored location (the form page) with pre-populated data
      stored_location
    else
      # Redirect to the default path after sign-in
      super
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
