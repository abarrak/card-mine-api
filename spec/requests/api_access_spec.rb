require 'rails_helper'

RSpec.describe "API Access Management", type: :request do
  # api http access token with the authentication hash
  let(:auth_bundled) { @auth_headers.merge api_access_hash }

  describe 'senarios of api access' do
    it 'allows static content fetch without app key access token' do
      ['about', 'contact'].each do |p|
        get "/api/v1/#{p}"
        expect(response).to have_http_status(200)
      end
    end

    it 'prevent others without the app key access token even when user is authenticated' do
      login
      get '/api/v1/cards', headers: @auth_headers
      expect(response).to have_http_status(401)
      logout
    end

    it 'allows access with a valid present app key' do
      login
      get '/api/v1/cards', headers: auth_bundled
      expect(response).to have_http_status(200)
      logout
    end
  end
end
