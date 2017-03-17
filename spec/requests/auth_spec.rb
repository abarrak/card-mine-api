require 'rails_helper'

RSpec.describe "Authentication", type: :request do
  let(:auth_bundled) { @auth_headers.merge api_access_hash }

  describe 'Sanitization' do
    let(:user_info) { attributes_for :user }

    it 'sanitizes the authentication params for sign up' do
    end

    it 'sanitizes the authentication params for account updates' do
    end
  end

  describe 'Email Confirmation' do
    it 'redirects after successful sign up to a safe url' do
    end
  end

  describe 'Registration' do
    it 'sends a confirmation message' do
    end
  end
end
