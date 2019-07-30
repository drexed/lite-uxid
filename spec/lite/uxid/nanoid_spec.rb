# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Lite::Uxid::Nanoid do
  let(:encoder) { described_class.new }

  describe '.encode' do
    it 'to be 26' do
      expect(described_class.encode.length).to eq(26)
    end
  end

  describe '.nanoid_encode' do
    it 'to be 26' do
      expect(encoder.nanoid_encode.length).to eq(26)
    end
  end

end
