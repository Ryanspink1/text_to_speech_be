class User < ApplicationRecord
  has_secure_password
  has_many :conversions
  enum role:[:default, :admin]

  validates :email,

            presence: true

  validates :email,

            uniqueness: true
end
