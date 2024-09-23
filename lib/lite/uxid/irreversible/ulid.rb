# frozen_string_literal: true

module Lite
  module Uxid
    module Irreversible
      class Ulid < Base

        MASK = 0x1f

        def encode
          oct = octect
          ele = "0" * coder_size
          pos = coder_size - 1

          while oct.positive?
            ele[pos] = coder_charset[oct & MASK]
            oct >>= 5
            pos -= 1
          end

          ele
        end

        private

        def bytes
          "#{unixtime_48bit}#{SecureRandom.random_bytes(10)}"
        end

        def octect
          (hi, lo) = bytes.unpack("Q>Q>")
          (hi << 64) | lo
        end

        def unixtime_ms
          time = Time.respond_to?(:current) ? Time.current : Time.now
          time.to_i * 1_000
        end

        def unixtime_48bit
          [unixtime_ms].pack("Q>")[2..-1]
        end

      end
    end
  end
end
