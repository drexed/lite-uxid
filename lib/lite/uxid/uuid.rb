# frozen_string_literal: true

module Lite
  module Uxid
    class Uuid < Irreversible

      def encode
        SecureRandom.uuid
      end

    end
  end
end
