# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Lite::Uxid::Configuration do
  after do
    Lite::Uxid.configure do |config|
      config.encoding_chars = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
    end
  end

  describe '#configure' do
    it 'to be "foo"' do
      Lite::Uxid.configuration.encoding_chars = 'foo'

      expect(Lite::Uxid.configuration.encoding_chars).to eq('foo')
    end
  end

end
