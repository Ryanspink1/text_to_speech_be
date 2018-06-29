class User < ApplicationRecord
  has_secure_password
  has_many :conversions
  has_many :speech_conversions
  enum role:[:default, :admin]

  validates :email,

            presence: true,
            'valid_email_2/email': true

  validates :email,

            uniqueness: true
end
