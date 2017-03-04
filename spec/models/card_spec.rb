# == Schema Information
#
# Table name: cards
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  user_id     :integer
#  template_id :integer
#  draft       :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Card, type: :model do

  example_group "relationships" do
    it { should belong_to(:user).dependent(:destroy) }
    it { should belong_to(:template) }
    it { should have_many(:textual_contents) }
  end

  example_group "validators" do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_least(3).is_at_most(40) }
  end

  let (:user) { create(:user) }
  let (:template) { create(:template) }

  example "Invalid state of card, then rectifying it" do
    card = Card.new title: 'AB', user_id: nil, template_id: nil
    expect(card).not_to be_valid
    expect(card.errors.count).to eq(3)

    card.title << "C"
    expect(card).not_to be_valid
    expect(card.errors.count).to eq(2)

    card.user = user
    expect(card).not_to be_valid
    expect(card.errors.count).to eq(1)

    card.template = template
    card.user = nil
    expect(card).not_to be_valid
    expect(card.errors.count).to eq(1)

    card.user = user
    expect(card).to be_valid
    expect(card.errors.count).to eq(0)
  end

  it "can't have a blank title" do
    my_card = Card.new user: user, template: template
    expect(my_card).not_to be_valid
    expect(my_card.errors).to have_key(:title)

    my_card.title = "My Card"
    expect(my_card).to be_valid
  end
end
