# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Lite::Uxid::Hash do
  let(:encoder) { described_class.new(10) }
  let(:decoder) { described_class.new('q5D8inm0') }

  describe '.decode' do
    it 'to be 10' do
      expect(described_class.decode('q5D8inm0')).to eq(10)
    end
  end

  describe '.decode_uxid' do
    it 'to be 10' do
      expect(decoder.decode_uxid).to eq(10)
    end
  end

  describe '.encode' do
    it 'to be "q5D8inm0"' do
      expect(described_class.encode(10)).to eq('q5D8inm0')
    end
  end

  describe '.encode_uxid' do
    it 'to be "q5D8inm0"' do
      expect(encoder.encode_uxid).to eq('q5D8inm0')
    end
  end

end
