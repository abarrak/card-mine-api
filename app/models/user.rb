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

class User < ActiveRecord::Base
  # Include default devise modules
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable,
         :validatable, :confirmable
  include DeviseTokenAuth::Concerns::User

  # Validators
  validates :nickname, presence: true, length: { minimum: 3, maximum: 35 },
            uniqueness: { case_sensitive: false }
  validates :email, presence: true, length: { minimum: 6, maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }

  # Associations
  has_many :cards, dependent: :destroy

  # Callbacks
  before_save :normalize_attrs

  # Methods and business Logic

  private

    def normalize_attrs
      self.email.downcase!
      self.nickname.downcase!
    end
end
