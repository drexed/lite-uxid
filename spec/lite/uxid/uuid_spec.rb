# frozen_string_literal: true

require "spec_helper"

RSpec.describe Lite::Uxid::Uuid do
  let(:encoder) { described_class.new }

  describe ".encode" do
    it "to be 36" do
      expect(described_class.encode.length).to eq(36)
      expect(encoder.encode.length).to eq(36)
    end
  end

end
