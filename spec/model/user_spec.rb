require 'rails_helper'

RSpec.describe User, type: :model do
  context "validations" do
    it { should validate_presence_of(:email)}

    it { is_expected.to validate_uniqueness_of(:email)}
  end

  context "relationships" do
    it { should have_many(:conversions) }
  end
end
