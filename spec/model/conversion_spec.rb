require 'rails_helper'

RSpec.describe Conversion, type: :model do
  context "validations" do
    it { should validate_presence_of(:original_text)}
    it { should validate_presence_of(:synthesized_mime)}
  end

  context "relationships" do
    it { should belong_to(:user) }
  end
end
