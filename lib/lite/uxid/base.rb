# frozen_string_literal: true

module Lite
  module Uxid
    module Base

      def encode
        raise NotImplementedError, "override encode method in #{coder_class}"
      end

      def decode
        raise NotImplementedError, "override decode method in #{coder_class}"
      end

      private

      def coder_value_for(key)
        sym_key = :"#{coder_class.downcase}_#{key}"
        return unless Lite::Uxid.configuration.respond_to?(sym_key)

        opts.delete(key) || Lite::Uxid.configuration.send(sym_key)
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

      def coder_prefix
        @coder_prefix ||= opts.delete(:prefix)
      end

      def coder_salt
        @coder_salt ||= coder_value_for(:salt)
      end

      def coder_size
        @coder_size ||= coder_value_for(:size)
      end

      def coder_spin
        @coder_spin ||= coder_value_for(:spin)
      end

      def coder_version
        @coder_version ||= coder_value_for(:version)
      end

    end
  end
end
