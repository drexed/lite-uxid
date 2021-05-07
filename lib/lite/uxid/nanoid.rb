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
        encoding_chars.chars.sample(encoding_length).join
      end

    end
  end
end
