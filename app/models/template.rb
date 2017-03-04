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

class Template < ApplicationRecord
  # Associations
  has_many :cards, dependent: :restrict_with_error

  # Validators
  validates :name, presence: true
  validates :image, presence: true
end
