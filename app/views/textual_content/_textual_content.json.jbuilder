json.extract! textual_content, :id, :card_id, :content, :x_position, :y_position, :width, :height,
                               :font_family, :font_size, :color, :created_at, :updated_at
json.url card_textual_content_url(textual_content, card_id: @card.to_param, format: :json)
