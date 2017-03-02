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
  pending "add some examples to (or delete) #{__FILE__}"
end
