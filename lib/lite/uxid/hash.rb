# frozen_string_literal: true

module Lite
  module Uxid
    class Hash < Lite::Uxid::Base

      def initialize(id)
        @id = id
        super()
      end

      class << self

        def encode(id)
          klass = new(id)
          klass.encode_uxid
        end

      end

      def self.decode(id)
        klass = new(id)
        klass.decode_uxid
      end

      def encode_uxid
        uxid_encode_chars((@id + encoding_salt) << encoding_length)
      end

      def decode_uxid
        (uxid_decode_chars(@id) >> encoding_length) - encoding_salt
      end

      def uxid_encode_chars(id)
        return '0' if id.zero?
        return nil if id.negative?

        str = ''

        while id.positive?
          str = "#{encoding_chars[id % encoding_base]}#{str}"
          id /= encoding_base
        end

        str
      end

      def uxid_decode_chars(id)
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
