# frozen_string_literal: true

require "spec_helper"

RSpec.describe Lite::Uxid::Hashid do
  let(:nid) { 10 }
  let(:hid) { "67wGI0" }
  let(:encoder) { described_class.new(nid) }
  let(:decoder) { described_class.new(hid) }

  describe ".decode" do
    it "to be 10" do
      expect(described_class.decode(hid)).to eq(nid)
      expect(decoder.decode).to eq(nid)
    end
  end

  describe ".encode" do
    it 'to be "67wGI0"' do
      expect(described_class.encode(nid)).to eq(hid)
      expect(encoder.encode).to eq(hid)
    end

    it "to be 6" do
      expect(described_class.encode(nid).length).to eq(6)
      expect(encoder.encode.length).to eq(6)
    end
  end

end
