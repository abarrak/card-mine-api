module ApiAccessHelper
  def access_token
    AppKey.create unless AppKey.any?
    AppKey.first.access_token
  end

  def api_access_hash
    { 'HTTP_AUTHORIZATION' =>
      ActionController::HttpAuthentication::Token.encode_credentials(access_token) }
  end
end
