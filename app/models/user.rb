class User < ApplicationRecord
  has_secure_password
  has_many :conversions
  has_many :speech_conversions
  enum role:[:default, :admin]

  validates :email,

            presence: true

  validates :email,

            uniqueness: true
end
