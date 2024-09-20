# frozen_string_literal: true

module Lite
  module Uxid

    class Configuration

      attr_accessor :hashid_charset, :hashid_size, :hashid_salt,
                    :nanoid_charset, :nanoid_size,
                    :ulid_charset,   :ulid_size,
                    :uuid_version

      def initialize
        @hashid_charset = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        @hashid_salt = 1_369_136
        @hashid_size = 16
        @nanoid_charset = "_-0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        @nanoid_size = 21
        @ulid_charset = "0123456789ABCDEFGHJKMNPQRSTVWXYZ"
        @ulid_size = 26
        @uuid_version = 4
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
