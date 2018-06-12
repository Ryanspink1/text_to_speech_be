require 'rails_helper'

RSpec.describe SpeechConversion, type: :model do
  context "validations" do
    it { should validate_presence_of(:text) }
    it { should validate_presence_of(:aws_location) }
  end

  context "relationships" do
    it { should belong_to(:user) }
  end
end
