class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include DeviseTokenAuth::Concerns::SetUserByToken
  include ExceptionHandler
  include ApiAccessManagement

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :resrict_api_access!

  protected
    # permit other devise params ..
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit :sign_up, keys: [:email, :password, :password_confirmation,
                                        :nickname, :first_name, :last_name]
      devise_parameter_sanitizer.permit :account_update, keys: [:email, :nickname, :password,
                                        :password_confirmation, :current_password]
    end

    # confirms if a user owns a resource and can operate on it.
    def authorized_for? resource
      resource.user.present? && resource.user.id == current_user.try(:id) ? true : false
    end

    def unauthorized_response
      render json: { errors: ["Authorized users only."] }, status: 401
    end
end
