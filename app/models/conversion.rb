class Conversion < ApplicationRecord
  belongs_to :user

  validates :original_text,
            :synthesized_mime,

            presence: true

  def self.save_to_public(phrase)
    encoded_phrase = phrase.gsub(' ', '_')
    # encoded_phrase = URI.encode(phrase)
    if !File.exist?("./public/conversions/#{encoded_phrase}.mp3")
      conversion = WatsonService.get(encoded_phrase)
      IO.write("./public/conversions/#{encoded_phrase}.mp3", conversion.force_encoding("UTF-8"))
    end
    encoded_phrase
  end
end
