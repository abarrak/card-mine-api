require "rails_helper"

RSpec.describe CardsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/api/v1/cards").to route_to("cards#index", :format => :json)
    end

    it "routes to #show" do
      expect(:get => "/api/v1/cards/1").to route_to("cards#show", :id => "1", :format => :json)
    end

    it "routes to #create" do
      expect(:post => "/api/v1/cards").to route_to("cards#create", :format => :json)
    end

    it "routes to #update via PUT" do
      expect(:put => "/api/v1/cards/1").to route_to("cards#update", :id => "1", :format => :json)
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/api/v1/cards/1").to route_to("cards#update", :id => "1", :format => :json)
    end

    it "routes to #destroy" do
      expect(:delete => "/api/v1/cards/1").to route_to("cards#destroy", :id => "1", :format => :json)
    end
  end
end
