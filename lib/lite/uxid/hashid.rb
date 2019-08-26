# frozen_string_literal: true

module Lite
  module Uxid
    class Hashid < Lite::Uxid::Base

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
        encode_chars((@id + encoding_salt) << encoding_length)
      end

      def decode
        (decode_chars(@id) >> encoding_length) - encoding_salt
      end

      private

      def encode_chars(id)
        return '0' if id.zero?
        return nil if id.negative?

        str = ''

        while id.positive?
          str = "#{encoding_chars[id % encoding_base]}#{str}"
          id /= encoding_base
        end

        str
      end

      def decode_chars(id)
        pos = 0
        num = 0
        len = id.length
        max = len - 1

        while pos < len
          pow = encoding_base**(max - pos)
          num += encoding_chars.index(id[pos]) * pow
          pos += 1
        end

        num
      end

    end
  end
end
