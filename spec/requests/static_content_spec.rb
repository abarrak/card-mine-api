require 'rails_helper'

RSpec.describe "Static Content API", type: :request do
  describe "GET /" do
    before { get '/' }

    it "responds with success status" do
      expect(response).to have_http_status(200)
    end

    it "returns landing content as json payload" do
      expect(json).not_to be_empty
      expect(json).to have_key('content')
    end

    it "gives the right content back to requester" do
      expect(json['content']).to eq(I18n.t 'content.home')
    end
  end

  describe "GET /api/v1/about" do
    before { get '/api/v1/about' }

    it "responds with success status" do
      expect(response).to have_http_status(200)
    end

    it "returns about content as json payload" do
      expect(json).not_to be_empty
      expect(json).to have_key('content')
    end

    it "gives the right content back to requester" do
      expect(json['content']).to eq(I18n.t 'content.about')
    end
  end

  describe "GET /api/v1/contact" do
    before { get '/api/v1/contact' }

    it "responds with success status" do
      expect(response).to have_http_status(200)
    end

    it "returns contact content as json payload" do
      expect(json).not_to be_empty
      expect(json).to have_key('content')
    end

    it "gives the right content back to requester" do
      expect(json['content']).to eq(I18n.t 'content.contact')
      p json['content']
    end
  end
end
