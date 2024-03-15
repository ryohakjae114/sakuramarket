# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: :create
  before_action :configure_account_update_params, only: :update
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[address last_name first_name])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: %i[address last_name first_name])
  end
end
