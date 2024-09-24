# frozen_string_literal: true

require "spec_helper"

RSpec.describe Lite::Uxid::Reversible::Hashid do
  let(:prefix) { nil }
  let(:id) { 10 }
  let(:hashid) { "7pau2oXSklq0" }
  let(:prefixed_hashid) { "test_7pau2oXSklq0" }
  let(:encoder) { described_class.new(id, prefix: prefix) }
  let(:decoder) { described_class.new(hashid, prefix: prefix) }

  describe ".decode" do
    it "to be 10" do
      expect(described_class.decode(hashid)).to eq(id)
      expect(decoder.decode).to eq(id)
    end

    context "with prefix" do
      let(:prefix) { "test_" }

      it "to be 10" do
        expect(described_class.decode(hashid, prefix: prefix)).to eq(id)
        expect(decoder.decode).to eq(id)
      end
    end
  end

  describe ".encode" do
    it 'to be "7pau2oXSklq0"' do
      expect(described_class.encode(id)).to eq(hashid)
      expect(encoder.encode).to eq(hashid)
    end

    it "to be 12" do
      expect(described_class.encode(id).length).to eq(12)
      expect(encoder.encode.length).to eq(12)
    end

    context "with prefix" do
      let(:prefix) { "test_" }

      it 'to be "test_7pau2oXSklq0"' do
        expect(described_class.encode(id, prefix: prefix)).to eq(prefixed_hashid)
        expect(encoder.encode).to eq(prefixed_hashid)
      end
    end
  end

end
