# frozen_string_literal: true

require "spec_helper"

RSpec.describe Lite::Uxid::Reversible::Scatterid do
  let(:prefix) { nil }
  let(:id) { 10 }
  let(:scatterid) { "2056964183" }
  let(:prefixed_scatterid) { "test_2056964183" }
  let(:encoder) { described_class.new(id, prefix: prefix) }
  let(:decoder) { described_class.new(scatterid, prefix: prefix) }

  describe ".decode" do
    it "to be 10" do
      expect(described_class.decode(scatterid)).to eq(id)
      expect(decoder.decode).to eq(id)
    end

    context "with prefix" do
      let(:prefix) { "test_" }

      it "to be 10" do
        expect(described_class.decode(scatterid, prefix: prefix)).to eq(id)
        expect(decoder.decode).to eq(id)
      end
    end
  end

  describe ".encode" do
    it "to be 2056964183" do
      expect(described_class.encode(id)).to eq(scatterid)
      expect(encoder.encode).to eq(scatterid)
    end

    it "to be 10" do
      expect(described_class.encode(id).size).to eq(10)
      expect(encoder.encode.size).to eq(10)
    end

    context "with prefix" do
      let(:prefix) { "test_" }

      it 'to be "test_2056964183"' do
        expect(described_class.encode(id, prefix: prefix)).to eq(prefixed_scatterid)
        expect(encoder.encode).to eq(prefixed_scatterid)
      end
    end
  end

end
