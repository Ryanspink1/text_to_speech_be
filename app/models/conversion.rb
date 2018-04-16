class Conversion < ApplicationRecord
  belongs_to :user

  validates :original_text,
            :synthesized_mime,

            presence: true
end
