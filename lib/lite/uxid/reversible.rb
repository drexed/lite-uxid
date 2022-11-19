# frozen_string_literal: true

module Lite
  module Uxid
    class Reversible < Irreversible

      attr_reader :id

      def initialize(id, opts = {})
        @id = id
        super(opts)
      end

      class << self

        def encode(id, opts = {})
          klass = new(id, opts)
          klass.encode
        end

        def decode(id, opts = {})
          klass = new(id, opts)
          klass.decode
        end

      end

      def decode
        raise NotImplementedError, "override method in #{coder_class}"
      end

    end
  end
end
