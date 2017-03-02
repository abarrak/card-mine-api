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

class Card < ApplicationRecord
  # Associations
  belongs_to :user, dependent: :destroy
  belongs_to :template
  has_many :textual_contents

  # Validators
  validates :title, presence: true, length: { minimum: 3, maximum: 35 }
  validates :user, :template, presence: true

  # Scopes
  default_scope -> { includes(:textual_contents) }

  # Callbacks

  # Methods and business Logic
end
