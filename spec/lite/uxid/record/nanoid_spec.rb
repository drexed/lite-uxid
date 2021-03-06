# frozen_string_literal: true

require 'spec_helper'

class NanoidUser < User; end

RSpec.describe Lite::Uxid::Record::Nanoid do
  let(:klass) { NanoidUser.include(described_class) }
  let(:user) { klass.create! }

  describe '.find_by_uxid(!)' do
    it 'to be user' do
      expect(klass.find_by_uxid(user.uxid)).to eq(user)
    end

    it 'to be nil' do
      expect(klass.find_by_uxid('123')).to eq(nil)
    end

    it 'to be an ActiveRecord::RecordNotFound error' do
      expect { klass.find_by_uxid!('123') }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe '.callback_generate_uxid!' do
    it 'to be 26' do
      expect(user.uxid.length).to eq(26)
    end
  end

end
