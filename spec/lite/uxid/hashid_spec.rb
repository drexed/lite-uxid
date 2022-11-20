# frozen_string_literal: true

require "spec_helper"

RSpec.describe Lite::Uxid::Hashid do
  let(:id) { 10 }
  let(:hashid) { "1zWr1m0" }
  let(:encoder) { described_class.new(id) }
  let(:decoder) { described_class.new(hashid) }

  describe ".decode" do
    it "to be 10" do
      expect(described_class.decode(hashid)).to eq(id)
      expect(decoder.decode).to eq(id)
    end
  end

  describe ".encode" do
    it 'to be "1zWr1m0"' do
      expect(described_class.encode(id)).to eq(hashid)
      expect(encoder.encode).to eq(hashid)
    end

    it "to be 7" do
      expect(described_class.encode(id).size).to eq(7)
      expect(encoder.encode.size).to eq(7)
    end
  end

end
