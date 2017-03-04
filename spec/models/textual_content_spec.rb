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
  context "Relationships" do
    it { should belong_to(:card).dependent(:destroy) }
    it { should have_one(:template).through(:card) }
  end

  context "Validators" do
    it { should validate_presence_of(:content) }
    it { should validate_numericality_of(:x_position).only_integer }
    it { should validate_numericality_of(:y_position).only_integer }
    it { should validate_numericality_of(:width).only_integer }
    it { should validate_numericality_of(:height).only_integer }
   end
end
