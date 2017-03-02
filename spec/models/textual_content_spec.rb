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

require 'rails_helper'

RSpec.describe TextualContent, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
