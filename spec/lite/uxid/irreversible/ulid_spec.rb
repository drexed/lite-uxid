# frozen_string_literal: true

require "spec_helper"

RSpec.describe Lite::Uxid::Irreversible::Ulid do
  let(:prefix) { nil }
  let(:encoder) { described_class.new(prefix: prefix) }

  describe ".encode" do
    it "to be 26" do
      expect(described_class.encode.length).to eq(26)
      expect(encoder.encode.length).to eq(26)
    end

    context "with prefix" do
      let(:prefix) { "test_" }

      it "to be prefixed" do
        expect(described_class.encode(prefix: prefix).starts_with?(prefix)).to eq(true)
        expect(encoder.encode.starts_with?(prefix)).to eq(true)
      end
    end
  end

end
