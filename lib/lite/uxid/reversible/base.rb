# frozen_string_literal: true

module Lite
  module Uxid
    module Reversible
      class Base

        include Lite::Uxid::Base

        attr_reader :id, :opts

        def initialize(id, opts = {})
          @id = id
          @opts = opts
        end

        def self.encode(id, opts = {})
          klass = new(id, opts)
          klass.encode
        end

        def self.decode(id, opts = {})
          klass = new(id, opts)
          klass.decode
        end

      end
    end
  end
end
