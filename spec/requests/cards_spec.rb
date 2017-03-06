require 'rails_helper'

RSpec.describe "Card resources API", type: :request do
  before do
    create :new_user
    create :card, user: User.last
  end

  let! (:recent_card_id) { Card.last.id }

  example_group "Access Control" do
    let (:expect_401_response) do
      proc {
        expect(response).to have_http_status(401)
        expect(json).to have_key('errors')
      }
    end

    it "denies unauthenticated access" do
      get "/api/v1/cards"
      expect_401_response.call

      post "/api/v1/cards/"
      expect_401_response.call

      get "/api/v1/cards/#{recent_card_id}"
      expect_401_response.call

      put "/api/v1/cards/#{recent_card_id}"
      expect_401_response.call

      patch "/api/v1/cards/#{recent_card_id}"
      expect_401_response.call

      delete "/api/v1/cards/#{recent_card_id}"
      expect_401_response.call
    end

    it "denies unauthorized access" do
      # will loging with a user where recent card is not her record ..
      login

      get "/api/v1/cards/#{recent_card_id}", headers: @auth_headers
      expect_401_response.call

      post "/api/v1/cards/"
      expect_401_response.call

      get "/api/v1/cards/#{recent_card_id}"
      expect_401_response.call

      put "/api/v1/cards/#{recent_card_id}"
      expect_401_response.call

      patch "/api/v1/cards/#{recent_card_id}"
      expect_401_response.call

      delete "/api/v1/cards/#{recent_card_id}"
      expect_401_response.call

      logout
    end
  end

  context "With logged authorized user" do
    before { login  }
    after  { logout }

    # Muti-resource specs

    describe "GET /api/v1/cards(.json)" do
      before do
        create :card, user: @user
        get '/api/v1/cards', headers: @auth_headers
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end

      it "and returns all her cards" do
        expect(json).to be_kind_of(Array)
        expect(json.size).to eq(@user.cards.count)
        expect(json.sample['user_id']).to eq(@user.id)
      end
    end

    describe "POST /api/v1/cards(.json)" do
      let(:valid_attributes) { build(:new_card).attributes }

      it "returns status code 201" do
        post '/api/v1/cards', params: { card: valid_attributes }, headers: @auth_headers
        expect(response).to have_http_status(201)
      end

      it "creates the submitted card" do
        expect {
          post '/api/v1/cards', params: { card: valid_attributes }, headers: @auth_headers
        }.to change(Card, :count).by(1)
      end

      it "associates created card to the submitter" do
        post '/api/v1/cards', params: { card: valid_attributes }, headers: @auth_headers
        expect(Card.last.user).to eq(@user)
      end
    end

    # Single resource specs

    # set up a specific card with path as subject.
    subject! do
      create :new_card, user: @user
      Card.last.to_param
    end
    let!(:subject_path) { "/api/v1/cards/#{subject}" }

    describe "GET /api/v1/cards/:id" do
      before { get subject_path, headers: @auth_headers }

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end

      it "and returns all of her cards" do
        expect(json).to be_kind_of(Hash)
        expect(json['user_id']).to eq(@user.id)
      end

      context "when record is not found" do
        it "returns 404" do
          get "/api/v1/cards/10000", headers: @auth_headers
          expect(response).to have_http_status(404)
        end
      end
    end

    describe "PATCH/PUT /api/v1/cards/:id(.json)" do
      let(:updated_attributes) { { title: 'My fancy title' } }

      it "returns status code 200" do
        patch subject_path, params: { card:  updated_attributes }, headers: @auth_headers
        expect(response).to have_http_status(200)
      end

      it "alters card datat" do
        patch subject_path, params: { card: updated_attributes }, headers: @auth_headers
        expect(json['title']).to eq(updated_attributes[:title])
      end

      it "cannot assigned user for a card as it's prevented" do
        patch subject_path, params: { card: { user_id: 1 } }, headers: @auth_headers
        expect(response).to have_http_status(422)

        get subject_path, headers: @auth_headers
        expect(json['user_id']).to eq(@user.id)
      end
    end

    describe "DELETE /api/v1/cards/:id(.json)" do
      it "returns status code 204" do
        delete subject_path, headers: @auth_headers
        expect(response).to have_http_status(204)
      end

      it "destroys the requseted record" do
        expect { delete subject_path, headers: @auth_headers }.to change(Card, :count).by(-1)
      end
    end
  end
end
