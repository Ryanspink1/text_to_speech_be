class Conversion < ApplicationRecord
  belongs_to :user

  validates :voice,
            :text,
            :aws_location,

            presence: true

  validates :aws_location,

            uniqueness: true

  def self.save_to_public(conversion_params)
    encoded_phrase = conversion_params[:text].gsub(' ', '_')
    # encoded_phrase = URI.encode(phrase)
    if !File.exist?("./public/conversions/#{encoded_phrase}_#{conversion_params[:voice]}.mp3")
      conversion = WatsonService.get(encoded_phrase, conversion_params[:voice])
      IO.write("./public/conversions/#{encoded_phrase}_#{conversion_params[:voice]}.mp3", conversion.force_encoding("UTF-8"))
    end
    encoded_phrase + "_" + conversion_params[:voice]
  end
end
