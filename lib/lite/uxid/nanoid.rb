# frozen_string_literal: true

require 'securerandom'

module Lite
  module Uxid
    class Nanoid < Lite::Uxid::Base

      class << self

        def encode
          klass = new
          klass.nanoid_encode
        end

      end

      def nanoid_encode
        encoding_length.times.with_object(''.dup) do |i, str|
          str << encoding_chars[(SecureRandom.rand * encoding_base).floor]
        end
      end

    end
  end
end
