# frozen_string_literal: true

module Lite
  module Uxid

    class Configuration

      attr_accessor :encoding_chars, :encoding_length, :encoding_salt

      def initialize
        @encoding_chars = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        @encoding_length = 26
        @encoding_salt = 1_369_136
      end

    end

    class << self

      attr_writer :configuration

      def configuration
        @configuration ||= Configuration.new
      end

      def configure
        yield(configuration)
      end

      def reset_configuration!
        @configuration = Configuration.new
      end

    end

  end
end
