# frozen_string_literal: true

module Lite
  module Uxid
    class Nanoid < Base

      def encode
        encoding_chars.chars.sample(nanoid_length).join
      end

    end
  end
end
