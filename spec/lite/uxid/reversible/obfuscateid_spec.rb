# frozen_string_literal: true

require "spec_helper"

RSpec.describe Lite::Uxid::Reversible::Obfuscateid do
  let(:prefix) { nil }
  let(:id) { 10 }
  let(:obfuscateid) { 2_056_964_183 }
  let(:encoder) { described_class.new(id) }
  let(:decoder) { described_class.new(obfuscateid) }

  describe ".decode" do
    it "to be 10" do
      expect(described_class.decode(obfuscateid)).to eq(id)
      expect(decoder.decode).to eq(id)
    end
  end

  describe ".encode" do
    it "to be 2056964183" do
      expect(described_class.encode(id)).to eq(obfuscateid)
      expect(encoder.encode).to eq(obfuscateid)
    end

    it "to be 10" do
      expect(described_class.encode(id).to_s.length).to eq(10)
      expect(encoder.encode.to_s.length).to eq(10)
    end
  end

end
