# frozen_string_literal: true

module Lite
  module Uxid
    module Irreversible
      class Nanoid < Base

        def encode
          uxid = +""

          loop do
            cached_bytes = bytes

            (0...step).each do |idx|
              byte = cached_bytes[idx] & mask
              char = byte && coder_charset[byte]
              next unless char

              uxid << char
              return "#{coder_prefix}#{uxid}" if uxid.size == coder_size
            end
          end

          "#{coder_prefix}#{uxid}"
        end

        private

        def bytes
          SecureRandom.random_bytes(coder_size).bytes
        end

        def mask
          @mask ||= (2 << (Math.log(coder_length - 1) / Math.log(2))) - 1
        end

        def step
          @step = (1.6 * mask * coder_size / coder_length).ceil
        end

      end
    end
  end
end
