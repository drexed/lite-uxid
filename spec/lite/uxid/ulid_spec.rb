# frozen_string_literal: true

require "spec_helper"

RSpec.describe Lite::Uxid::Ulid do
  let(:encoder) { described_class.new }

  describe ".encode" do
    it "to be 26" do
      expect(described_class.encode.size).to eq(26)
      expect(encoder.encode.size).to eq(26)
    end
  end

end
