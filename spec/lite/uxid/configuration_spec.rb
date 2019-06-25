# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Lite::Uxid::Configuration do
  after(:all) do
    Lite::Uxid.configure do |config|
      config.encoding_chars = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
      config.encoding_length = 26
      config.encoding_salt = 1_369_136
    end
  end

  describe '#configure' do
    it 'to be "foo" for encoding_chars' do
      Lite::Uxid.configuration.encoding_chars = 'foo'

      expect(Lite::Uxid.configuration.encoding_chars).to eq('foo')
    end

    it 'to be "foo" for encoding_length' do
      Lite::Uxid.configuration.encoding_length = 'foo'

      expect(Lite::Uxid.configuration.encoding_length).to eq('foo')
    end

    it 'to be "foo" for encoding_salt' do
      Lite::Uxid.configuration.encoding_salt = 'foo'

      expect(Lite::Uxid.configuration.encoding_salt).to eq('foo')
    end
  end

end
