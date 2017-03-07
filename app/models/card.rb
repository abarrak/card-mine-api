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
  belongs_to :user
  belongs_to :template
  has_many :textual_content, dependent: :destroy

  accepts_nested_attributes_for :textual_content, allow_destroy: true

  # Validators
  validates :title, presence: true, length: { minimum: 3, maximum: 40 }
  validate :ensure_owner_user

  # Scopes
  default_scope { includes(:textual_content) }

  # Callbacks

  # Methods and business Logic
  private

    def ensure_owner_user
      ids = self.changes[:user_id]
      return if ids.nil? || ids.try(:first).nil?
      errors[:user] << 'has no premission to alter card owner.' unless ids.first == ids.last
    end
end
