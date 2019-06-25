# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Lite::Uxid::Ulid do
  let(:encoder) { described_class.new }

  describe '.encode' do
    it 'to be 26' do
      expect(described_class.encode.length).to eq(26)
    end
  end

  describe '.uxid_encode' do
    it 'to be 26' do
      expect(encoder.uxid_encode.length).to eq(26)
    end
  end

  describe '.uxid_bytes' do
    it 'to be 16' do
      expect(encoder.uxid_bytes.length).to eq(16)
    end
  end

  describe '.uxid_octect' do
    it 'to be a random string' do
      expect(encoder.uxid_octect).not_to eq(nil)
    end
  end

  describe '.uxid_unixtime_flex' do
    it 'to be a random integer' do
      expect(encoder.uxid_unixtime_flex).not_to eq(nil)
    end
  end

  describe '.uxid_unixtime_48bit' do
    it 'to be 6' do
      expect(encoder.uxid_unixtime_48bit.length).to eq(6)
    end
  end

end
