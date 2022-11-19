# frozen_string_literal: true

module Lite
  module Uxid
    class Nanoid < Base

      def encode(opts = {})
        chars = opts.delete(:chars) || encoding_chars
        length = opts.delete(:length) || nanoid_length

        chars.chars.sample(length).join
      end

    end
  end
end
