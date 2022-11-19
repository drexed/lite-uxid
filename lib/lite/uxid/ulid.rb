# frozen_string_literal: true

require "securerandom" unless defined?(SecureRandom)

module Lite
  module Uxid
    class Ulid < Irreversible

      MASK = 0x1f

      def encode
        oct = octect
        ele = "0" * coder_length
        pos = coder_length - 1

        while oct.positive?
          ele[pos] = coder_chars[oct & MASK]
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
        (time.to_f * 1_000).to_i
      end

      def unixtime_48bit
        [unixtime_ms].pack("Q>")[2..-1]
      end

    end
  end
end
