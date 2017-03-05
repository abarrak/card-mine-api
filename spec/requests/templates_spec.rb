require 'rails_helper'

RSpec.describe "Templates API endpoint", type: :request do
  describe "GET for all public available templates" do
    let (:path) { "/api/v1/templates#{['', '.json'].sample}" }
    before { get path }

    it "respond with success status" do
      expect(response).to have_http_status(200)
    end

    it "returns the templates json data" do
      expect(json).to be_empty

      create_list :templates_list, 10
      get path
      expect(json).not_to be_empty
      expect(json.size).to eq(Template.count)
    end
  end
end

