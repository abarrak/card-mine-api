# == Schema Information
#
# Table name: templates
#
#  id          :integer          not null, primary key
#  name        :string
#  image       :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Template, type: :model do
  describe "relationships" do
    it { should have_many(:cards).dependent(:restrict_with_error) }
  end

  describe "validators" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:image) }
  end
end
