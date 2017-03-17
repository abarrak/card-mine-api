require "rails_helper"

RSpec.describe TextualContentController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/api/v1/cards/1/textual_content").to route_to("textual_content#index",
             :card_id => "1", :format => :json)
    end

    it "routes to #show" do
      expect(:get => "/api/v1/cards/1/textual_content/1").to route_to("textual_content#show",
             :id => "1", :card_id => "1", :format => :json)
    end

    it "routes to #create" do
      expect(:post => "/api/v1/cards/1/textual_content").to route_to("textual_content#create",
             :card_id => "1", :format => :json)
    end

    it "routes to #update via PUT" do
      expect(:put => "/api/v1/cards/1/textual_content/1").to route_to("textual_content#update",
             :id => "1", :card_id => "1", :format => :json)
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/api/v1/cards/1/textual_content/1").to route_to("textual_content#update",
             :id => "1", :card_id => "1", :format => :json)
    end

    it "routes to #destroy" do
      expect(:delete => "/api/v1/cards/1/textual_content/1").to route_to("textual_content#destroy",
             :id => "1", :card_id => "1", :format => :json)
    end
  end
end
