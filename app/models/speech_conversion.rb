class SpeechConversion < ApplicationRecord
belongs_to :user

validates :text,
          :aws_location,

          presence: true

validates :aws_location,

          uniqueness: true

  def self.get_count
    if last
      last.id + 1
    else
      1
    end
  end
end
