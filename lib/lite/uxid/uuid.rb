# frozen_string_literal: true

require "securerandom" unless defined?(SecureRandom)

module Lite
  module Uxid
    class Uuid < Irreversible

      def encode
        SecureRandom.uuid
      end

    end
  end
end
