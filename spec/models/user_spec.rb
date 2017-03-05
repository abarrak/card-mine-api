# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  provider               :string           default("email"), not null
#  uid                    :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  email                  :string
#  nickname               :string
#  first_name             :string
#  last_name              :string
#  tokens                 :json
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

RSpec.describe User, type: :model do
  context "Relationships" do
    it { should have_many(:cards).dependent(:destroy) }
  end

  context "Validators" do
    let (:sample) { build(:user) }

    it { should validate_presence_of(:nickname) }
    it { should validate_presence_of(:email) }
    it { should validate_length_of(:nickname).is_at_least(3).is_at_most(30) }
    it { should validate_length_of(:email).is_at_least(7).is_at_most(255) }
    it { should validate_length_of(:password).is_at_least(6).is_at_most(128) }

    context "Uniqueness validatoions" do
      subject { sample }
      it { should validate_uniqueness_of(:email).case_insensitive }
      it { should validate_uniqueness_of(:nickname).case_insensitive }
    end

    it "rejects invalid emails" do
      expect(sample).to be_valid
      %w( a@.kaa aaa@..com  abc.com.a iurnswq.@.com not@so,good).each do |e|
        sample.email = e
        expect(sample).not_to be_valid
      end
    end
  end
end
