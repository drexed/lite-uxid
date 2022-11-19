# frozen_string_literal: true

module Lite
  module Uxid
    class Base

      def initialize
        @config = Lite::Uxid.configuration
      end

      class << self

        def encode
          klass = new
          klass.encode
        end

      end

      def encoding_base
        encoding_chars.length
      end

      Lite::Uxid.configuration.instance_variables.each do |setting|
        setting = setting.to_s.tr(":@", "")
        define_method(setting) { @config.send(setting) }
      end

    end
  end
end
