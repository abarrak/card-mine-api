require 'rails_helper'

RSpec.describe "Textual Content resources API", type: :request do
  # api http access token with the authentication hash
  let(:auth_bundled) { @auth_headers.merge api_access_hash }

  before do
    create :new_user
    create :card, user: User.last
    create :textual_content, card: Card.last
  end

  let! (:recent_card_id) { Card.last.id }
  let! (:recent_textual_content_id) { TextualContent.last.id }

  example_group "Access Control" do
    let (:expect_401_response) do
      proc {
        expect(response).to have_http_status(401)
        expect(json).to have_key('errors')
      }
    end

    example "denies unauthenticated access" do
      get "/api/v1/cards/#{recent_card_id}/textual_content", headers: api_access_hash
      expect_401_response.call

      post "/api/v1/cards/#{recent_card_id}/textual_content", headers: api_access_hash
      expect_401_response.call

      get "/api/v1/cards/#{recent_card_id}/textual_content/#{recent_textual_content_id}",
          headers: api_access_hash
      expect_401_response.call

      put "/api/v1/cards/#{recent_card_id}/textual_content/#{recent_textual_content_id}",
          headers: api_access_hash
      expect_401_response.call

      patch "/api/v1/cards/#{recent_card_id}/textual_content/#{recent_textual_content_id}",
            headers: api_access_hash
      expect_401_response.call

      delete "/api/v1/cards/#{recent_card_id}/textual_content/#{recent_textual_content_id}",
             headers: api_access_hash
      expect_401_response.call
    end

    example "denies unauthorized access" do
      # will loging with a user where recent card is not her record ..
      login

      get "/api/v1/cards/#{recent_card_id}/textual_content", headers: auth_bundled
      expect_401_response.call

      post "/api/v1/cards/#{recent_card_id}/textual_content", headers: auth_bundled
      expect_401_response.call

      get "/api/v1/cards/#{recent_card_id}/textual_content/#{recent_textual_content_id}",
          headers: auth_bundled
      expect_401_response.call

      put "/api/v1/cards/#{recent_card_id}/textual_content/#{recent_textual_content_id}",
          headers: auth_bundled
      expect_401_response.call

      patch "/api/v1/cards/#{recent_card_id}/textual_content/#{recent_textual_content_id}",
            headers: auth_bundled
      expect_401_response.call

      delete "/api/v1/cards/#{recent_card_id}/textual_content/#{recent_textual_content_id}",
             headers: auth_bundled
      expect_401_response.call

      logout
    end
  end

  context "With logged authorized user" do
    before { login  }
    after  { logout }

    # Muti-resource specs

    describe "GET /api/v1/cards/:card_id/textual_content(.json)" do
      before do
        create :card, user: @user
        @card = Card.last
        create :textual_content, card: @card
        get "/api/v1/cards/#{@card.to_param}/textual_content", headers: auth_bundled
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end

      it "and returns all her card's textual content" do
        expect(json).to be_kind_of(Array)
        expect(json.size).to eq(@card.textual_content.count)
        expect(json.sample['card_id']).to eq(@card.id)
      end
    end

    describe "POST /api/v1/cards/:card_id/textual_content(.json)" do
      let(:card) {
        create :card, user: @user
        Card.last
      }
      let(:valid_attributes) { build(:textual_content, card: card).attributes }

      it "returns status code 201" do
        post "/api/v1/cards/#{card.to_param}/textual_content",
             params: { textual_content: valid_attributes }, headers: auth_bundled
        expect(response).to have_http_status(201)
      end

      it "creates the submitted textual content" do
        expect {
        post "/api/v1/cards/#{card.to_param}/textual_content",
             params: { textual_content: valid_attributes }, headers: auth_bundled
        }.to change(TextualContent, :count).by(1)
      end

      it "associates created textual content with the card" do
        post "/api/v1/cards/#{card.to_param}/textual_content",
             params: { textual_content: valid_attributes }, headers: auth_bundled
        expect(TextualContent.last.card).to eq(card)
      end

      context "with invalid attributes" do
        let(:invalid_attrs) {
          valid_attributes.tap { |attrs| attrs[:content] = '' }
        }

        it "retunrs 422 status code" do
          post "/api/v1/cards/#{card.to_param}/textual_content",
               params: { textual_content: invalid_attrs }, headers: auth_bundled
          expect(response).to have_http_status(422)
        end

        it "does not create the card record" do
          expect {
            post "/api/v1/cards/#{card.to_param}/textual_content",
                 params: { textual_content: invalid_attrs }, headers: auth_bundled
          }.not_to change(TextualContent, :count)
        end
      end
    end

    # Single resource specs

    # set up a specific card with path as subject.
    subject! do
      create :card, user: @user
      @card = Card.last
      create :textual_content, card: @card
      TextualContent.last.to_param
    end

    let!(:subject_path) { "/api/v1/cards/#{@card.id}/textual_content/#{subject}" }

    describe "GET /api/v1/cards/:card_id/textual_content/:id" do
      before { get subject_path, headers: auth_bundled }

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end

      it "and returns the requested textual content item" do
        expect(json).to be_kind_of(Hash)
        expect(json['card_id']).to eq(@card.id)
      end

      context "when record is not found" do
        it "returns 404" do
          get "/api/v1/cards/#{@card.id}/textual_content/10000", headers: auth_bundled
          expect(response).to have_http_status(404)
        end
      end
    end

    describe "PATCH/PUT /api/v1/cards/:id(.json)" do
      let(:updated_attributes) { { content: 'A wise quote here ..' } }

      it "returns status code 200" do
        patch subject_path, params: { textual_content: updated_attributes }, headers: auth_bundled
        expect(response).to have_http_status(200)
      end

      it "alters textual content data" do
        patch subject_path, params: { textual_content: updated_attributes }, headers: auth_bundled
        expect(json['content']).to eq(updated_attributes[:content])
      end

      context "when record is not found" do
        it "returns 404" do
          patch "/api/v1/cards/#{@card.id}/textual_content/999999", params: { textual_content: updated_attributes },
                headers: auth_bundled
          expect(response).to have_http_status(404)
        end
      end

      context "with invalid date for update" do
        let(:invalid_data) { { x_position: 10.40 } }

        it "retunrs 422 status code" do
          patch subject_path, params: { textual_content: invalid_data }, headers: auth_bundled
          expect(response).to have_http_status(422)
        end

        it "does not alter the record" do
          patch subject_path, params: { textual_content: invalid_data }, headers: auth_bundled
          expect(TextualContent.last.x_position).not_to eq(invalid_data[:x_position])
        end
      end
    end

    describe "DELETE /api/v1/cards/:id(.json)" do
      it "returns status code 200" do
        delete subject_path, headers: auth_bundled
        expect(response).to have_http_status(200)
      end

      it "with confirmation message" do
        delete subject_path, headers: auth_bundled
        expect(json['message']).not_to be_empty
      end

      it "destroys the requseted record" do
        expect {
          delete subject_path, headers: auth_bundled
        }.to change(TextualContent, :count).by(-1)
      end

      context "when record is not found" do
        it "returns 404" do
          delete "/api/v1/cards/#{@card.id}/textual_content/999999", headers: auth_bundled
          expect(response).to have_http_status(404)
        end
      end
    end

  end
end
