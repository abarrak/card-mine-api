json.extract! card, :id, :title, :description, :user_id, :template_id, :draft, :textual_contents,
                    :created_at, :updated_at
json.url card_url(card, format: :json)
