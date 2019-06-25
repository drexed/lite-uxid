# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Lite::Uxid::Base do
  let(:base) { described_class.new }

  describe '.encoding_base' do
    it 'to be 62' do
      expect(base.encoding_base).to eq(62)
    end
  end

  describe '.encoding_chars' do
    chars = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'

    it "to be #{chars}" do
      expect(base.encoding_chars).to eq(chars)
    end
  end

  describe '.encoding_length' do
    it 'to be 26' do
      expect(base.encoding_length).to eq(26)
    end
  end

  describe '.encoding_salt' do
    it 'to be 1_369_136' do
      expect(base.encoding_salt).to eq(1_369_136)
    end
  end

end
