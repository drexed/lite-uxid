# frozen_string_literal: true

module Lite
  module Uxid
    module Irreversible
      class Uuid < Base

        def encode
          encoded_id =
            case coder_version
            when 7
              SecureRandom.uuid_v7
            else
              SecureRandom.uuid
            end

          "#{coder_prefix}#{encoded_id}"
        end

      end
    end
  end
end
