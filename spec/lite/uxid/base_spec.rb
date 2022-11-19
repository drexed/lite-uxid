# frozen_string_literal: true

require "spec_helper"

RSpec.describe Lite::Uxid::Base do
  let(:base) { described_class.new }

  describe ".encoding_chars" do
    chars = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

    it "to be #{chars}" do
      expect(base.encoding_chars).to eq(chars)
    end
  end

  describe ".encoding_salt" do
    it "to be 1_369_136" do
      expect(base.encoding_salt).to eq(1_369_136)
    end
  end

  describe ".hashid_length" do
    it "to be 12" do
      expect(base.hashid_length).to eq(12)
    end
  end

  describe ".nanoid_length" do
    it "to be 21" do
      expect(base.nanoid_length).to eq(21)
    end
  end

  describe ".ulid_length" do
    it "to be 26" do
      expect(base.ulid_length).to eq(26)
    end
  end

end
