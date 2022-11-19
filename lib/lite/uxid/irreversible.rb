# frozen_string_literal: true

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

      def coder_base
        @coder_base ||= coder_chars.length
      end

      def coder_chars
        @coder_chars ||=
          opts.delete(:chars) ||
          Lite::Uxid.configuration.encoding_chars
      end

      def coder_class
        @coder_class ||= self.class.name.split("::").last
      end

      def coder_length
        @coder_length ||=
          opts.delete(:length) ||
          Lite::Uxid.configuration.send("#{coder_class.downcase}_length")
      end

      def coder_salt
        @coder_salt ||=
          opts.delete(:salt) ||
          Lite::Uxid.configuration.encoding_salt
      end

    end
  end
end
