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

        def encode(id, opts = {})
          klass = new(id)
          klass.encode(opts)
        end

        def decode(id, opts = {})
          klass = new(id)
          klass.decode(opts)
        end

      end

      def encode(opts = {})
        chars = opts.delete(:chars) || encoding_chars
        length = opts.delete(:length) || hashid_length

        encode_chars((id + encoding_salt) << length, chars)
      end

      def decode(opts = {})
        chars = opts.delete(:chars) || encoding_chars
        length = opts.delete(:length) || hashid_length

        (decode_chars(id, chars) >> length) - encoding_salt
      end

      private

      def encode_chars(decoded_id, chars)
        return "0" if decoded_id.zero?
        return nil if decoded_id.negative?

        base = chars.length
        str = ""

        while decoded_id.positive?
          str = "#{chars[decoded_id % base]}#{str}"
          decoded_id /= base
        end

        str
      end

      def decode_chars(encoded_id, chars)
        base = chars.length

        pos = 0
        num = 0
        len = encoded_id.length
        max = len - 1

        while pos < len
          pow = base**(max - pos)
          num += chars.index(encoded_id[pos]) * pow
          pos += 1
        end

        num
      end

    end
  end
end
