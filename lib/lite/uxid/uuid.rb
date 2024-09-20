# frozen_string_literal: true

module Lite
  module Uxid
    class Uuid < Base::Irreversible

      def encode
        case coder_version
        when 7
          SecureRandom.uuid_v7
        else
          SecureRandom.uuid
        end
      end

    end
  end
end
