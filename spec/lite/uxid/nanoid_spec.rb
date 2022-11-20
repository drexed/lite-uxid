# frozen_string_literal: true

require "spec_helper"

RSpec.describe Lite::Uxid::Nanoid do
  let(:encoder) { described_class.new }

  describe ".encode" do
    it "to be 21" do
      expect(described_class.encode.size).to eq(21)
      expect(encoder.encode.size).to eq(21)
    end
  end

end
