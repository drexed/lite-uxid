# frozen_string_literal: true

module Lite
  module Uxid
    class Nanoid < Lite::Uxid::Base

      class << self

        def encode
          klass = new
          klass.encode
        end

      end

      def encode
        str = ''
        len = encoding_length
        chars = encoding_chars.split(str)

        while len.positive?
          str += chars.sample
          len -= 1
        end

        str
      end

    end
  end
end
