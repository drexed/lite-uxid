# frozen_string_literal: true

require "spec_helper"

class NanoidUser < User; end

RSpec.describe Lite::Uxid::Record::Nanoid do
  let(:klass) { NanoidUser.include(described_class) }
  let(:user) { klass.create! }

  describe ".callback_generate_uxid!" do
    it "to be 21" do
      expect(user.uxid.length).to eq(21)
    end

    it 'to be "fake-id"' do
      user = User.create!(uxid: "fake-id")

      expect(user.uxid).to eq("fake-id")
    end
  end

end
