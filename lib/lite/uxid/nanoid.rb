# frozen_string_literal: true

module Lite
  module Uxid
    class Nanoid < Base::Irreversible

      def encode
        (0...coder_size).each_with_object(+"") do |i, str|
          str << coder_charset[coder_bytes[i] & 63]
        end
      end

    end
  end
end
