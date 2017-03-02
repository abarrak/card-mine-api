# == Schema Information
#
# Table name: textual_contents
#
#  id          :integer          not null, primary key
#  content     :text
#  x_position  :integer
#  y_position  :integer
#  font_family :string
#  font_size   :string
#  color       :string
#  card_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  width       :integer
#  height      :integer
#

class TextualContent < ApplicationRecord
  # Associations
  belongs_to :card, dependent: :destroy

  # Validators

  # Callbacks

  # Methods and business Logic
end
