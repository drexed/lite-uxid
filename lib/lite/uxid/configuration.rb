# frozen_string_literal: true

module Lite
  module Uxid

    ALPHANUMERIC = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    COCKFORDS_32 = "0123456789ABCDEFGHJKMNPQRSTVWXYZ"
    WEB_SAFE     = "#{ALPHANUMERIC}-_".freeze

    class Configuration

      attr_accessor :hashid_charset, :hashid_salt,
                    :nanoid_charset, :nanoid_size,
                    :obfuscateid_spin,
                    :ulid_charset, :ulid_size,
                    :uuid_version

      def initialize
        @hashid_charset = ALPHANUMERIC
        @hashid_salt = 1_369_136
        @nanoid_charset = WEB_SAFE
        @nanoid_size = 21
        @obfuscateid_spin = 0
        @ulid_charset = COCKFORDS_32
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
