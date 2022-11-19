# frozen_string_literal: true

module Lite
  module Uxid
    class Hashid < Reversible

      def encode
        encode_chars((id + coder_salt) << coder_length)
      end

      def decode
        (decode_chars(id) >> coder_length) - coder_salt
      end

      private

      def encode_chars(decoded_id)
        return "0" if decoded_id.zero?
        return nil if decoded_id.negative?

        str = ""

        while decoded_id.positive?
          str = "#{coder_chars[decoded_id % coder_base]}#{str}"
          decoded_id /= coder_base
        end

        str
      end

      def decode_chars(encoded_id)
        pos = 0
        num = 0
        len = encoded_id.length
        max = len - 1

        while pos < len
          pow = coder_base**(max - pos)
          num += coder_chars.index(encoded_id[pos]) * pow
          pos += 1
        end

        num
      end

    end
  end
end
