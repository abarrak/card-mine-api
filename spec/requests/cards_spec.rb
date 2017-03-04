require 'rails_helper'

RSpec.describe "Cards", type: :request do

  describe "GET /templates" do
    it "Respond with success status" do
      get templates_path
      expect(response).to have_http_status(200)
    end
  end
end

