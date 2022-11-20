# frozen_string_literal: true

require "spec_helper"

RSpec.describe Lite::Uxid::Uuid do
  let(:encoder) { described_class.new }

  describe ".encode" do
    it "to be 36" do
      expect(described_class.encode.size).to eq(36)
      expect(encoder.encode.size).to eq(36)
    end
  end

end
