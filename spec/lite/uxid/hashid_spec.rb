# frozen_string_literal: true

require "spec_helper"

RSpec.describe Lite::Uxid::Hashid do
  let(:nid) { 10 }
  let(:hid) { "q5D8inm0" }
  let(:encoder) { described_class.new(nid) }
  let(:decoder) { described_class.new(hid) }

  describe ".decode" do
    it "to be 10" do
      expect(described_class.decode(hid)).to eq(nid)
      expect(decoder.decode).to eq(nid)
    end
  end

  describe ".encode" do
    it 'to be "q5D8inm0"' do
      expect(described_class.encode(nid)).to eq(hid)
      expect(encoder.encode).to eq(hid)
    end
  end

end
