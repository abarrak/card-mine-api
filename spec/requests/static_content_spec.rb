require 'rails_helper'

RSpec.describe "Static Content", type: :request do
  describe "GET /" do
    before { get '/' }

    it "responds with success status" do
      expect(response).to have_http_status(200)
    end

    it "returns landing content as json payload" do
      expect(json).not_to be_empty
    end
  end

  describe "GET /api/v1/about" do
    before { get '/api/v1/about' }

    it "responds with success status" do
      expect(response).to have_http_status(200)
    end

    it "returns about content as json payload" do
      expect(json).not_to be_empty
    end
  end

  describe "GET /api/v1/contact" do
    before { get '/api/v1/contact' }

    it "responds with success status" do
      expect(response).to have_http_status(200)
    end

    it "returns contact content as json payload" do
      expect(json).not_to be_empty
    end
  end
end
