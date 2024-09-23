# frozen_string_literal: true

module Lite
  module Uxid
    module Irreversible
      class Base

        include Lite::Uxid::Base

        attr_reader :opts

        def initialize(opts = {})
          @opts = opts
        end

        def self.encode(opts = {})
          klass = new(opts)
          klass.encode
        end

        def self.decode(opts = {})
          klass = new(opts)
          klass.decode
        end

        def decode
          raise "#{coder_class} does not support decoding"
        end

      end
    end
  end
end
