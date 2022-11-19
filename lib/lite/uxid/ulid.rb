# frozen_string_literal: true

require "securerandom" unless defined?(SecureRandom)

module Lite
  module Uxid
    class Ulid < Base

      MASK = 0x1f

      def encode(opts = {})
        chars = opts.delete(:chars) || encoding_chars
        length = opts.delete(:length) || ulid_length

        oct = octect
        ele = "0" * length
        pos = length - 1

        while oct.positive?
          ele[pos] = chars[oct & MASK]
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
