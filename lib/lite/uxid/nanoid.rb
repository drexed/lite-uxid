# frozen_string_literal: true

module Lite
  module Uxid
    class Nanoid < Lite::Uxid::Base

      class << self

        def encode
          klass = new
          klass.nanoid_encode
        end

      end

      # rubocop:disable Performance/UnfreezeString
      def nanoid_encode
        chars = encoding_chars.split('')

        encoding_length.times.reduce(''.dup) do |str, _|
          str << chars.sample
        end
      end
      # rubocop:enable Performance/UnfreezeString

    end
  end
end
