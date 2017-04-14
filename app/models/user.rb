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

class User < ApplicationRecord
  # Include default devise modules
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable,
         :validatable, :confirmable
  include DeviseTokenAuth::Concerns::User

  # Associations
  has_many :cards, -> { includes(:textual_content) }, dependent: :destroy

  # Validators
  validates :nickname, presence: true, length: { minimum: 3, maximum: 30 },
                       format: { with: /\A[a-z0-9\-_]+\z/i, message: :nickname_format },
                       uniqueness: { case_sensitive: false }
  validates :email, presence: true, length: { minimum: 7, maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }

  # Callbacks
  before_save :normalize_attrs

  # Methods and business Logic

  def send_devise_notification notification, *args
    devise_mailer.send(notification, self, *args).deliver_later
  end

  private

    def normalize_attrs
      self.email.downcase! if self.email.respond_to? :downcase!
      self.nickname.downcase! if self.nickname.respond_to? :downcase!
    end
end
