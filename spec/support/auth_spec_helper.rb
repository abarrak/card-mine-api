# A set of `devise_token_auth` helpers needed for authenticated_request, etc.
module AuthSpecHelper
  def login
    set_user
    @auth_headers = @user.create_new_auth_token if @user.tokens.empty?
  end

  def logout
    @auth_headers = nil
  end

  def register
    set_user
    user.confirm
  end

  def cancel_account
  end

  private

    def set_user
      return if @user
      create :user
      @user = User.last
    end
end
