# frozen_string_literal: true

require "spec_helper"

class ObfuscateidUser < User; end

RSpec.describe Lite::Uxid::Record::Obfuscateid do
  let(:klass) { ObfuscateidUser.include(described_class) }
  let(:user) { klass.create! }

  describe ".find_by_uxid(!)" do
    it "to be user" do
      expect(klass.find_by_uxid(user.uxid)).to eq(user)
    end

    it "to be nil" do
      expect(klass.find_by_uxid("123")).to be_nil
    end

    it "to be an ActiveRecord::RecordNotFound error" do
      expect { klass.find_by_uxid!("123") }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe ".id_to_uxid" do
    it "to be 4517239960" do
      expect(user.id_to_uxid).to eq(4517239960)
    end
  end

  describe ".uxid_to_id" do
    it "to be 1" do
      expect(user.uxid_to_id).to eq(1)
    end
  end

  describe ".callback_generate_uxid!" do
    it "to be 10" do
      expect(user.uxid.length).to eq(10)
    end

    it 'to be "fake-id"' do
      user = User.create!(uxid: "fake-id")

      expect(user.uxid).to eq("fake-id")
    end
  end

end
