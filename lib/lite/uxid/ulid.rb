# frozen_string_literal: true

require 'securerandom'

module Lite
  module Uxid
    class Ulid < Lite::Uxid::Base

      MASK ||= 0x1f

      class << self

        def encode
          klass = new
          klass.uxid_encode
        end

      end

      def uxid_encode
        oct = uxid_octect
        ele = '0' * encoding_length
        pos = encoding_length - 1

        while oct.positive?
          ele[pos] = encoding_chars[oct & MASK]
          oct >>= 5
          pos -= 1
        end

        ele
      end

      private

      def uxid_bytes
        "#{uxid_unixtime_48bit}#{SecureRandom.random_bytes(10)}"
      end

      def uxid_octect
        (hi, lo) = uxid_bytes.unpack('Q>Q>')
        (hi << 64) | lo
      end

      def uxid_unixtime_flex
        time = Time.respond_to?(:current) ? Time.current : Time.now
        (time.to_f * 1_000).to_i
      end

      def uxid_unixtime_48bit
        [uxid_unixtime_flex].pack('Q>')[2..-1]
      end

    end
  end
end
