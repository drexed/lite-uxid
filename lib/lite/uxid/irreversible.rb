# frozen_string_literal: true

require "securerandom" unless defined?(SecureRandom)

module Lite
  module Uxid
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

      def coder_bytes
        @coder_bytes ||= SecureRandom.random_bytes(coder_size).bytes
      end

      def coder_charset
        @coder_charset ||=
          opts.delete(:charset) ||
          Lite::Uxid.configuration.send(:"#{coder_class.downcase}_charset")
      end

      def coder_class
        @coder_class ||= self.class.name.split("::").last
      end

      def coder_length
        @coder_length ||= coder_charset.size
      end

      def coder_salt
        @coder_salt ||=
          opts.delete(:salt) ||
          Lite::Uxid.configuration.send(:"#{coder_class.downcase}_salt")
      end

      def coder_size
        @coder_size ||=
          opts.delete(:size) ||
          Lite::Uxid.configuration.send(:"#{coder_class.downcase}_size")
      end

    end
  end
end
