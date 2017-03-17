require "rails_helper"

RSpec.describe TemplatesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/api/v1/templates").to route_to("templates#index", :format => :json)
    end
  end
end
