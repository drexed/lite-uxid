# frozen_string_literal: true

require "spec_helper"

class UlidUser < User; end

RSpec.describe Lite::Uxid::Record::Uuid do
  let(:klass) { UlidUser.include(described_class) }
  let(:user) { klass.create! }

  describe ".callback_generate_uxid!" do
    it "to be 36" do
      expect(user.uxid.size).to eq(36)
    end

    it 'to be "fake-id"' do
      user = User.create!(uxid: "fake-id")

      expect(user.uxid).to eq("fake-id")
    end
  end

end
