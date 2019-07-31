# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Lite::Uxid::Nanoid do
  let(:encoder) { described_class.new }

  describe '.encode' do
    it 'to be 26' do
      n1 = 26

      expect(described_class.encode.length).to eq(n1)
      expect(encoder.encode.length).to eq(n1)
    end
  end

end
