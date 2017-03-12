module ApiAccessManagement
  # Api request should add ```Authorization:Token token=<access_token>``` header
  # in order to be authenticated.
  def resrict_api_access!
    authenticate_or_request_with_http_token 'Application', error_message do |token, options|
        AppKey.exists? access_token: token
    end
  end

  private

    def error_message
      @api_restricted_error_message ||= I18n.t 'errors.api_restricted_access'
    end
end
