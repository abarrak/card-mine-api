require 'rails_helper'

RSpec.describe AppKey, type: :model do

  describe "AppKey persistence" do
    let (:key) { AppKey.new }

    it "ensures access_token existence before creation" do
      expect(key.access_token).to be_nil

      key.save
      expect(key.access_token).not_to be_empty
    end

    it "prevents collisions" do
      key.save

      new_key = AppKey.new
      new_key.access_token = key.access_token
      expect(new_key).not_to be_valid

      expect(new_key.save).to be_falsy
    end
  end

end
