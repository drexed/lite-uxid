# frozen_string_literal: true

module Lite
  module Uxid
    class Hashid < Base

      attr_reader :id

      def initialize(id)
        @id = id
        super()
      end

      class << self

        def encode(id)
          klass = new(id)
          klass.encode
        end

        def decode(id)
          klass = new(id)
          klass.decode
        end

      end

      def encode
        encode_chars((id + encoding_salt) << hashid_length)
      end

      def decode
        (decode_chars(id) >> hashid_length) - encoding_salt
      end

      private

      def encode_chars(decoded_id)
        return "0" if decoded_id.zero?
        return nil if decoded_id.negative?

        str = ""

        while decoded_id.positive?
          str = "#{encoding_chars[decoded_id % encoding_base]}#{str}"
          decoded_id /= encoding_base
        end

        str
      end

      def decode_chars(encoded_id)
        pos = 0
        num = 0
        len = encoded_id.length
        max = len - 1

        while pos < len
          pow = encoding_base**(max - pos)
          num += encoding_chars.index(encoded_id[pos]) * pow
          pos += 1
        end

        num
      end

    end
  end
end
