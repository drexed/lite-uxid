# frozen_string_literal: true

require "spec_helper"

RSpec.describe Lite::Uxid::Configuration do
  after { Lite::Uxid.reset_configuration! }

  describe "#configure" do
    it 'to be "foo"' do
      Lite::Uxid.configuration.hashid_charset = "foo"

      expect(Lite::Uxid.configuration.hashid_charset).to eq("foo")
    end
  end

  describe "#reset_configuration!" do
    it "to be true" do
      Lite::Uxid.configuration.hashid_charset = "foo"
      Lite::Uxid.reset_configuration!

      expect(Lite::Uxid.configuration.hashid_charset.start_with?("0123")).to be(true)
    end
  end

end
