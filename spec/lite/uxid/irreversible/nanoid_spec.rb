# frozen_string_literal: true

require "spec_helper"

RSpec.describe Lite::Uxid::Irreversible::Nanoid do
  let(:prefix) { nil }
  let(:encoder) { described_class.new(prefix: prefix) }

  describe ".encode" do
    it "to be 21" do
      expect(described_class.encode.length).to eq(21)
      expect(encoder.encode.length).to eq(21)
    end

    context "with prefix" do
      let(:prefix) { "test_" }

      it 'to be a prefixed string' do
        expect(described_class.encode(prefix: prefix).starts_with?(prefix)).to be(true)
        expect(encoder.encode.starts_with?(prefix)).to be(true)
      end
    end
  end

end
