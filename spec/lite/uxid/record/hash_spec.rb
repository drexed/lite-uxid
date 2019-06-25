# frozen_string_literal: true

require 'spec_helper'

class HashUser < User; end

RSpec.describe Lite::Uxid::Record::Hash do
  let(:klass) { HashUser.include(Lite::Uxid::Record::Hash) }
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

  describe '.uxid_to_id' do
    it 'to be 1' do
      expect(user.uxid_to_id).to eq(1)
    end
  end

  describe '.callback_generate_uxid!' do
    it 'to be 8' do
      expect(user.uxid.length).to eq(8)
    end
  end

end
