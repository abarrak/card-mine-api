require 'rails_helper'

RSpec.describe "Card resources API", type: :request do
  # api http access token with the authentication hash
  let(:auth_bundled) { @auth_headers.merge api_access_hash }

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

    example "denies unauthenticated access" do
      get "/api/v1/cards", headers: api_access_hash
      expect_401_response.call

      post "/api/v1/cards/", headers: api_access_hash
      expect_401_response.call

      get "/api/v1/cards/#{recent_card_id}", headers: api_access_hash
      expect_401_response.call

      put "/api/v1/cards/#{recent_card_id}", headers: api_access_hash
      expect_401_response.call

      patch "/api/v1/cards/#{recent_card_id}", headers: api_access_hash
      expect_401_response.call

      delete "/api/v1/cards/#{recent_card_id}", headers: api_access_hash
      expect_401_response.call
    end

    example "denies unauthorized access" do
      # will loging with a user where recent card is not her record ..
      login

      get "/api/v1/cards/#{recent_card_id}", headers: auth_bundled
      expect_401_response.call

      get "/api/v1/cards/#{recent_card_id}", headers: auth_bundled
      expect_401_response.call

      put "/api/v1/cards/#{recent_card_id}", headers: auth_bundled
      expect_401_response.call

      patch "/api/v1/cards/#{recent_card_id}", headers: auth_bundled
      expect_401_response.call

      delete "/api/v1/cards/#{recent_card_id}", headers: auth_bundled
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
        get '/api/v1/cards', headers: auth_bundled
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
        post '/api/v1/cards', params: { card: valid_attributes }, headers: auth_bundled
        expect(response).to have_http_status(201)
      end

      it "creates the submitted card" do
        expect {
          post '/api/v1/cards', params: { card: valid_attributes }, headers: auth_bundled
        }.to change(Card, :count).by(1)
      end

      it "associates created card to the submitter" do
        post '/api/v1/cards', params: { card: valid_attributes }, headers: auth_bundled
        expect(Card.last.user).to eq(@user)
      end

      context "Nested textual content creation with card is allowed" do
        let (:valid_attributes_with_textual_content) {
          tc = build(:textual_content, card: nil).attributes
          valid_attributes[:textual_content_attributes] = [tc]
          valid_attributes
        }

        it "returns 200" do
          post '/api/v1/cards', params: { card: valid_attributes_with_textual_content },
               headers: auth_bundled
          expect(response).to have_http_status(201)
        end

        it "creates the submitted card" do
          expect {
            post '/api/v1/cards', params: { card: valid_attributes_with_textual_content },
                 headers: auth_bundled
          }.to change(Card, :count).by(1)
        end

        it "creates the submitted card with textual content" do
          expect {
            post '/api/v1/cards', params: { card: valid_attributes_with_textual_content },
                 headers: auth_bundled
          }.to change(TextualContent, :count).by(1)
        end

        it "associates created card to the submitter & textual content with the card" do
          post '/api/v1/cards', params: { card: valid_attributes_with_textual_content },
               headers: auth_bundled

          created_card = Card.last
          expect(created_card.user).to eq(@user)
          expect(TextualContent.last.card).to eq(created_card)
        end
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
      before { get subject_path, headers: auth_bundled }

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end

      it "and returns the requested card" do
        expect(json).to be_kind_of(Hash)
        expect(json['user_id']).to eq(@user.id)
      end

      context "when record is not found" do
        it "returns 404" do
          get "/api/v1/cards/10000", headers: auth_bundled
          expect(response).to have_http_status(404)
        end
      end
    end

    describe "PATCH/PUT /api/v1/cards/:id(.json)" do
      let(:updated_attributes) { { title: 'My fancy title' } }

      it "returns status code 200" do
        patch subject_path, params: { card: updated_attributes }, headers: auth_bundled
        expect(response).to have_http_status(200)
      end

      it "alters card data" do
        patch subject_path, params: { card: updated_attributes }, headers: auth_bundled
        expect(json['title']).to eq(updated_attributes[:title])
      end

      it "cannot change assigned owner user as it's prevented" do
        patch subject_path, params: { card: { user_id: 1 } }, headers: auth_bundled
        expect(response).to have_http_status(422)

        get subject_path, headers: auth_bundled
        expect(json['user_id']).to eq(@user.id)
      end

      context "Nested textual content creation & updating within card updates is allowed" do
        let (:updated_attributes_textual_content) {
          tc = build(:textual_content, card: nil).attributes
          updated_attributes[:textual_content_attributes] = [tc]
          # Sometimes with cards changes, and sometimes with textual content changes only
          [updated_attributes, { textual_content_attributes: [tc] }].sample
        }

        it "returns status code 200" do
          patch subject_path, params: { card: updated_attributes_textual_content },
                headers: auth_bundled
          expect(response).to have_http_status(200)
        end

        it "alters card data and creates any new nested textual content" do
          patch subject_path, params: { card: updated_attributes_textual_content },
                headers: auth_bundled
          expect(json['title']).to eq(updated_attributes[:title]) if updated_attributes.key? :card
          expect([
            json['textual_content'].last['content'],
            json['textual_content'].last['x_position'],
            json['textual_content'].last['y_position'],
            json['textual_content'].last['width'],
            json['textual_content'].last['height'],
            json['textual_content'].last['font_family'],
            json['textual_content'].last['font_size'],
            json['textual_content'].last['color']
          ]).to eq([
            updated_attributes_textual_content[:textual_content_attributes].last['content'],
            updated_attributes_textual_content[:textual_content_attributes].last['x_position'],
            updated_attributes_textual_content[:textual_content_attributes].last['y_position'],
            updated_attributes_textual_content[:textual_content_attributes].last['width'],
            updated_attributes_textual_content[:textual_content_attributes].last['height'],
            updated_attributes_textual_content[:textual_content_attributes].last['font_family'],
            updated_attributes_textual_content[:textual_content_attributes].last['font_size'],
            updated_attributes_textual_content[:textual_content_attributes].last['color']
          ])
        end

        it "alters card data and/or the nested textual content" do
          # Humm this one is gonna be tricky ..
        end
      end

      it "allows destruction of textual_content along with card update" do
      end

      context "when record is not found" do
        it "returns 404" do
          patch "/api/v1/cards/999999", params: { ard: updated_attributes }, headers: auth_bundled
          expect(response).to have_http_status(404)
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
        expect { delete subject_path, headers: auth_bundled }.to change(Card, :count).by(-1)
      end

      context "when record is not found" do
        it "returns 404" do
          delete "/api/v1/cards/999999", headers: auth_bundled
          expect(response).to have_http_status(404)
        end
      end
    end
  end
end
