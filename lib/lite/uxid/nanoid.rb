# frozen_string_literal: true

module Lite
  module Uxid
    class Nanoid < Irreversible

      def encode
        coder_chars.chars.sample(coder_length).join
      end

    end
  end
end
