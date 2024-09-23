# frozen_string_literal: true

require "spec_helper"

RSpec.describe Lite::Uxid::Reversible::Obfuscateid do
  let(:prefix) { nil }
  let(:id) { 10 }
  let(:obfuscateid) { "2056964183" }
  let(:prefixed_obfuscateid) { "test_2056964183" }
  let(:encoder) { described_class.new(id, prefix: prefix) }
  let(:decoder) { described_class.new(obfuscateid, prefix: prefix) }

  describe ".decode" do
    it "to be 10" do
      expect(described_class.decode(obfuscateid)).to eq(id)
      expect(decoder.decode).to eq(id)
    end

    context "with prefix" do
      let(:prefix) { "test_" }

      it "to be 10" do
        expect(described_class.decode(obfuscateid, prefix: prefix)).to eq(id)
        expect(decoder.decode).to eq(id)
      end
    end
  end

  describe ".encode" do
    it "to be 2056964183" do
      expect(described_class.encode(id)).to eq(obfuscateid)
      expect(encoder.encode).to eq(obfuscateid)
    end

    it "to be 10" do
      expect(described_class.encode(id).size).to eq(10)
      expect(encoder.encode.size).to eq(10)
    end

    context "with prefix" do
      let(:prefix) { "test_" }

      it 'to be "test_2056964183"' do
        expect(described_class.encode(id, prefix: prefix)).to eq(prefixed_obfuscateid)
        expect(encoder.encode).to eq(prefixed_obfuscateid)
      end
    end
  end

end
