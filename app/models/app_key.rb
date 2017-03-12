class AppKey < ApplicationRecord
  before_create :generate_access_token

  private

  def generate_access_token
    begin
      self.access_token = random_token
    end while self.class.exists? access_token: access_token
  end

  def random_token
    SecureRandom.urlsafe_base64 48
  end
end
