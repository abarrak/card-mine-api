class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
    # Permit other devise params ..
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit :sign_up, keys: [:email, :password, :password_confirmation,
                                        :nickname, :first_name, :last_name]
      devise_parameter_sanitizer.permit :account_update, keys: [:email, :nickname, :password,
                                        :password_confirmation, :current_password]
    end
end
