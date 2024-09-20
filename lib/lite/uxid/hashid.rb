# frozen_string_literal: true

module Lite
  module Uxid
    class Hashid < Base::Reversible

      def encode
        encode_chars((id + coder_salt) << coder_size)
      end

      def decode
        (decode_chars(id) >> coder_size) - coder_salt
      end

      private

      def encode_chars(decoded_id)
        return "0" if decoded_id.zero?
        return nil if decoded_id.negative?

        str = ""

        while decoded_id.positive?
          str = "#{coder_charset[decoded_id % coder_length]}#{str}"
          decoded_id /= coder_length
        end

        str
      end

      def decode_chars(encoded_id)
        pos = 0
        num = 0
        len = encoded_id.size
        max = len - 1

        while pos < len
          pow = coder_length**(max - pos)
          num += coder_charset.index(encoded_id[pos]) * pow
          pos += 1
        end

        num
      end

    end
  end
end
