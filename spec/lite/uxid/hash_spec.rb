# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Lite::Uxid::Hash do
  let(:encoder) { described_class.new(10) }
  let(:decoder) { described_class.new('q5D8inm0') }

  describe '.encode' do
    it 'to be "q5D8inm0"' do
      expect(described_class.encode(10)).to eq('q5D8inm0')
    end
  end

  describe '.decode' do
    it 'to be 10' do
      expect(described_class.decode('q5D8inm0')).to eq(10)
    end
  end

  describe '.encode_uxid' do
    it 'to be "q5D8inm0"' do
      expect(encoder.encode_uxid).to eq('q5D8inm0')
    end
  end

  describe '.decode_uxid' do
    it 'to be 10' do
      expect(decoder.decode_uxid).to eq(10)
    end
  end

  describe '.uxid_encode_chars' do
    it 'to be "n"' do
      expect(encoder.uxid_encode_chars(23)).to eq('n')
    end

    it 'to be "0"' do
      expect(encoder.uxid_encode_chars(0)).to eq('0')
    end

    it 'to be nil' do
      expect(encoder.uxid_encode_chars(-1)).to eq(nil)
    end
  end

  describe '.uxid_decode_chars' do
    it 'to be 23' do
      expect(decoder.uxid_decode_chars('n')).to eq(23)
    end

    it 'to be 0' do
      expect(decoder.uxid_decode_chars('0')).to eq(0)
    end
  end

end
