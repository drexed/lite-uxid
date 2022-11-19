# frozen_string_literal: true

module Lite
  module Uxid

    class Configuration

      attr_accessor :encoding_chars, :encoding_salt, :hashid_length, :nanoid_length, :ulid_length

      def initialize
        @encoding_chars = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        @encoding_salt = 1_369_136
        @hashid_length = 12
        @nanoid_length = 21
        @ulid_length = 26
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
