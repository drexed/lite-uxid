# frozen_string_literal: true

require "securerandom" unless defined?(SecureRandom)

module Lite
  module Uxid
    module Base
      class Irreversible

        attr_reader :opts

        def initialize(opts = {})
          @opts = opts
        end

        class << self

          def encode(opts = {})
            klass = new(opts)
            klass.encode
          end

          def decode(opts = {})
            klass = new(opts)
            klass.decode
          end

        end

        def encode
          raise NotImplementedError, "override method in #{coder_class}"
        end

        def decode
          raise NotImplementedError, "coder does not support decoding"
        end

        private

        def coder_value_for(key)
          sym_key = :"#{coder_class.downcase}_#{key}"
          return unless Lite::Uxid.configuration.respond_to?(sym_key)

          opts.delete(key) || Lite::Uxid.configuration.send(sym_key)
        end

        def coder_bytes
          @coder_bytes ||= SecureRandom.random_bytes(coder_size).bytes
        end

        def coder_charset
          @coder_charset ||= coder_value_for(:charset)
        end

        def coder_class
          @coder_class ||= self.class.name.split("::").last
        end

        def coder_length
          @coder_length ||= coder_charset.size
        end

        def coder_salt
          @coder_salt ||= coder_value_for(:salt)
        end

        def coder_size
          @coder_size ||= coder_value_for(:size)
        end

        def coder_version
          @coder_version ||= coder_value_for(:version)
        end

      end
    end
  end
end
