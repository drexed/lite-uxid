# frozen_string_literal: true

module Lite
  module Uxid
    class Configuration

      attr_accessor :encoding_chars, :encoding_length, :encoding_salt

      def initialize
        @encoding_chars = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
        @encoding_length = 26
        @encoding_salt = 1_369_136
      end

    end

    def self.configuration
      @configuration ||= Configuration.new
    end

    def self.configuration=(config)
      @configuration = config
    end

    def self.configure
      yield(configuration)
    end

  end
end
